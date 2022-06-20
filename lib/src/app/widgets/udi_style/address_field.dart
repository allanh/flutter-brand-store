import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../device/utils/my_plus_colors.dart';
import 'udi_field.dart';

class AddressField extends StatefulWidget {
  const AddressField({
    Key? key,

    // listener
    this.onFocusChange,
    this.onValueChange,

    // value
    this.defaultZip,
    this.defaultAddress,
    this.errorMessage,

    // style
    this.fieldType = FieldType.underline,
  }) : super(key: key);

  // listener
  final ValueChanged<bool>? onFocusChange;
  final Function(String?, String?, String?, String?)? onValueChange;

  // value
  final String? defaultZip;
  final String? defaultAddress;
  final String? errorMessage;

  // style
  final FieldType? fieldType;

  @override
  State<AddressField> createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  late TextEditingController zipTextController;
  final districtDropdownState = GlobalKey<FormFieldState>();
  final cityDropdownState = GlobalKey<FormFieldState>();

  // selected value
  String? _citySelectedValue; // format: "臺北市"
  String? _districtSelectedValue; // format: "100-中正區"
  String? get _selectedZip => _districtSelectedValue?.split("-")[0]; // format: "100"
  String? get _selectedArea => _districtSelectedValue?.split("-")[1]; // format: "100"
  String address = '';

  var districtMap = {for (var item in cityData) item['name'] as String: item['districts'] as List};
  List? _districts;

  bool isChangeZip = false;

  void _notifyInputChange() {
    debugPrint('_districtSelectedValue: $_citySelectedValue $_districtSelectedValue');
    if (_districtSelectedValue != null && address.isNotEmpty) {
      widget.onValueChange?.call(_selectedZip, _citySelectedValue, _selectedArea, address);
    }
  }

  @override
  void initState() {
    super.initState();
    var zip = widget.defaultZip;
    if (zip != null) {
      var value = zipData[zip[0]]?[zip[1]]?[zip[2]];
      var city = value?['city'];
      var area = value?['name']; // 300, 600 多個行政區共用郵遞區號
      var zipArea = zip == "300" || zip == "600" ? "$zip-${area?.split("/")[0]}" : "$zip-$area";
      if (area != null) {
        zipTextController = TextEditingController(text: zip);
        _districts = districtMap[city] ?? [];
        _citySelectedValue = city;
        _districtSelectedValue = zipArea;
      } else {
        zipTextController = TextEditingController();
      }
    } else {
      zipTextController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(flex: 26, child: _zipField()),
            const SizedBox(width: 12),
            Expanded(flex: 35, child: _cityDropdown()),
            const SizedBox(width: 12),
            Expanded(flex: 35, child: _districtDropdown())
          ],
        ),
        const SizedBox(height: 16),
        _addressField(),
      ],
    );
  }

  Widget _zipField() => Focus(
      onFocusChange: (isFocused) {
        if (!isFocused && _districtSelectedValue != null) {
          setState(() => zipTextController.text = _selectedZip ?? '');
        }
      },
      child: TextFormField(
          controller: zipTextController,
          onChanged: (zip) async {
            if (zip.length == 3 && zip != _selectedZip) {
              var value = zipData[zip[0]]?[zip[1]]?[zip[2]];
              var city = value?['city'];
              var area = value?['name']; // 300, 600 多個行政區共用郵遞區號
              var zipArea = zip == "300" || zip == "600" ? "$zip-${area?.split("/")[0]}" : "$zip-$area";

              if (area == null) {
                bool? delete = await showNotFindDialog(zip);
                if (delete == true) {
                  setState(() {
                    isChangeZip = true;
                    zipTextController.text = '';
                    isChangeZip = false;
                  });
                }
              } else {
                setState(() {
                  isChangeZip = true;
                  _districtSelectedValue = null;
                  _districts = districtMap[city] ?? [];
                  cityDropdownState.currentState?.didChange(city);
                  districtDropdownState.currentState?.didChange(zipArea);
                  isChangeZip = false;
                });
              }
            }
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(3),
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            hintText: '郵遞區號',
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: widget.fieldType == FieldType.outline ? 10 : 0,
            ),

            // 因錯誤訊息前需有圖示icon，故另外處理錯誤訊息，此處僅單純的變更輸入框線顏色
            errorText: widget.errorMessage != null ? '' : null,
            errorStyle: const TextStyle(height: 0, color: Colors.transparent),
            errorBorder: _border(UdiColors.danger),
            focusedErrorBorder: _border(UdiColors.danger),
            enabledBorder: _border(UdiColors.defaultBorder),
            focusedBorder: _border(UdiColors.focusedBorder),
          )));

  Widget _cityDropdown() {
    return DropdownButtonFormField<String>(
      decoration: _getInputDecoration(),
      key: cityDropdownState,
      hint: const Text('縣市'),
      items: cityData.asMap().entries.map((e) {
        String cityName = e.value['name'] as String;
        return DropdownMenuItem(child: Text(cityName), value: cityName);
      }).toList(),
      value: _citySelectedValue,
      onChanged: (String? cityName) => setState(() {
        if (cityName != _citySelectedValue) {
          _citySelectedValue = cityName;
          _districtSelectedValue = null;
          _districts = districtMap[cityName] ?? [];

          if (!isChangeZip) {
            _districtSelectedValue = _districts?.map((e) => '${e['zip']}-${e['name']}').first;
            zipTextController.text = _selectedZip ?? '';
            _notifyInputChange();
          }
        }
      }),
    );
  }

  Widget _districtDropdown() {
    return DropdownButtonFormField<String>(
      decoration: _getInputDecoration(),
      key: districtDropdownState,
      hint: const Text('鄉鎮市區'),
      items: _districts?.asMap().entries.map((e) {
            String zip = e.value['zip'] as String;
            String districtName = e.value['name'] as String;
            return DropdownMenuItem(child: Text(districtName), value: '$zip-$districtName');
          }).toList() ??
          [],
      value: _districtSelectedValue,
      onChanged: (String? value) => setState(() {
        if (value != _districtSelectedValue) {
          _districtSelectedValue = value;
          zipTextController.text = _selectedZip ?? '';
          _notifyInputChange();
        }
      }),
    );
  }

  UdiField _addressField() {
    return UdiField(
      onValueChange: (value) => setState(() {
        address = value;
        _notifyInputChange();
      }),
      defaultValue: widget.defaultAddress,
      hintText: '請輸入街號、樓層',
      fieldType: widget.fieldType,
      errorMessage: widget.errorMessage,
    );
  }

  Future<bool?> showNotFindDialog(String zip) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("查無郵遞區號"),
        content: Text("查無郵遞區號『$zip』，請重新輸入"),
        actions: <Widget>[
          TextButton(
            child: const Text("確認"),
            onPressed: () => Navigator.of(context).pop(true),
          )
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration() => InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(
          widget.fieldType == FieldType.outline ? 10 : 0,
          11,
          widget.fieldType == FieldType.outline ? 10 : 0,
          11,
        ),
        // 因錯誤訊息前需有圖示icon，故另外處理錯誤訊息，此處僅單純的變更輸入框線顏色
        errorText: widget.errorMessage != null ? '' : null,
        errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        errorBorder: _border(UdiColors.danger),
        focusedErrorBorder: _border(UdiColors.danger),
        enabledBorder: _border(UdiColors.defaultBorder),
        focusedBorder: _border(UdiColors.focusedBorder),
      );

  InputBorder _border(Color color) => widget.fieldType == FieldType.outline
      ? OutlineInputBorder(borderSide: BorderSide(color: color))
      : UnderlineInputBorder(borderSide: BorderSide(color: color));

  @override
  void dispose() {
    zipTextController.dispose();
    super.dispose();
  }
}

const zipData = {
  "1": {
    "0": {
      "0": {"zip": "100", "name": "中正區", "city": "臺北市"},
      "3": {"zip": "103", "name": "大同區", "city": "臺北市"},
      "4": {"zip": "104", "name": "中山區", "city": "臺北市"},
      "5": {"zip": "105", "name": "松山區", "city": "臺北市"},
      "6": {"zip": "106", "name": "大安區", "city": "臺北市"},
      "8": {"zip": "108", "name": "萬華區", "city": "臺北市"}
    },
    "1": {
      "0": {"zip": "110", "name": "信義區", "city": "臺北市"},
      "1": {"zip": "111", "name": "士林區", "city": "臺北市"},
      "2": {"zip": "112", "name": "北投區", "city": "臺北市"},
      "4": {"zip": "114", "name": "內湖區", "city": "臺北市"},
      "5": {"zip": "115", "name": "南港區", "city": "臺北市"},
      "6": {"zip": "116", "name": "文山區", "city": "臺北市"}
    }
  },
  "2": {
    "0": {
      "0": {"zip": "200", "name": "仁愛區", "city": "基隆市"},
      "1": {"zip": "201", "name": "信義區", "city": "基隆市"},
      "2": {"zip": "202", "name": "中正區", "city": "基隆市"},
      "3": {"zip": "203", "name": "中山區", "city": "基隆市"},
      "4": {"zip": "204", "name": "安樂區", "city": "基隆市"},
      "5": {"zip": "205", "name": "暖暖區", "city": "基隆市"},
      "6": {"zip": "206", "name": "七堵區", "city": "基隆市"},
      "7": {"zip": "207", "name": "萬里區", "city": "新北市"},
      "8": {"zip": "208", "name": "金山區", "city": "新北市"},
      "9": {"zip": "209", "name": "南竿鄉", "city": "連江縣"}
    },
    "1": {
      "0": {"zip": "210", "name": "北竿鄉", "city": "連江縣"},
      "1": {"zip": "211", "name": "莒光鄉", "city": "連江縣"},
      "2": {"zip": "212", "name": "東引鄉", "city": "連江縣"}
    },
    "2": {
      "0": {"zip": "220", "name": "板橋區", "city": "新北市"},
      "1": {"zip": "221", "name": "汐止區", "city": "新北市"},
      "2": {"zip": "222", "name": "深坑區", "city": "新北市"},
      "3": {"zip": "223", "name": "石碇區", "city": "新北市"},
      "4": {"zip": "224", "name": "瑞芳區", "city": "新北市"},
      "6": {"zip": "226", "name": "平溪區", "city": "新北市"},
      "7": {"zip": "227", "name": "雙溪區", "city": "新北市"},
      "8": {"zip": "228", "name": "貢寮區", "city": "新北市"}
    },
    "3": {
      "1": {"zip": "231", "name": "新店區", "city": "新北市"},
      "2": {"zip": "232", "name": "坪林區", "city": "新北市"},
      "3": {"zip": "233", "name": "烏來區", "city": "新北市"},
      "4": {"zip": "234", "name": "永和區", "city": "新北市"},
      "5": {"zip": "235", "name": "中和區", "city": "新北市"},
      "6": {"zip": "236", "name": "土城區", "city": "新北市"},
      "7": {"zip": "237", "name": "三峽區", "city": "新北市"},
      "8": {"zip": "238", "name": "樹林區", "city": "新北市"},
      "9": {"zip": "239", "name": "鶯歌區", "city": "新北市"}
    },
    "4": {
      "1": {"zip": "241", "name": "三重區", "city": "新北市"},
      "2": {"zip": "242", "name": "新莊區", "city": "新北市"},
      "3": {"zip": "243", "name": "泰山區", "city": "新北市"},
      "4": {"zip": "244", "name": "林口區", "city": "新北市"},
      "7": {"zip": "247", "name": "蘆洲區", "city": "新北市"},
      "8": {"zip": "248", "name": "五股區", "city": "新北市"},
      "9": {"zip": "249", "name": "八里區", "city": "新北市"}
    },
    "5": {
      "1": {"zip": "251", "name": "淡水區", "city": "新北市"},
      "2": {"zip": "252", "name": "三芝區", "city": "新北市"},
      "3": {"zip": "253", "name": "石門區", "city": "新北市"}
    },
    "6": {
      "0": {"zip": "260", "name": "宜蘭市", "city": "宜蘭縣"},
      "3": {"zip": "263", "name": "壯圍鄉", "city": "宜蘭縣"},
      "1": {"zip": "261", "name": "頭城鎮", "city": "宜蘭縣"},
      "2": {"zip": "262", "name": "礁溪鄉", "city": "宜蘭縣"},
      "4": {"zip": "264", "name": "員山鄉", "city": "宜蘭縣"},
      "5": {"zip": "265", "name": "羅東鎮", "city": "宜蘭縣"},
      "6": {"zip": "266", "name": "三星鄉", "city": "宜蘭縣"},
      "7": {"zip": "267", "name": "大同鄉", "city": "宜蘭縣"},
      "8": {"zip": "268", "name": "五結鄉", "city": "宜蘭縣"},
      "9": {"zip": "269", "name": "冬山鄉", "city": "宜蘭縣"}
    },
    "7": {
      "0": {"zip": "270", "name": "蘇澳鎮", "city": "宜蘭縣"},
      "2": {"zip": "272", "name": "南澳鄉", "city": "宜蘭縣"}
    },
    "9": {
      "0": {"zip": "290", "name": "釣魚臺", "city": "釣魚臺"}
    }
  },
  "3": {
    "0": {
      "0": {"zip": "300", "name": "東區/北區/香山區", "city": "新竹市"},
      "2": {"zip": "302", "name": "竹北市", "city": "新竹縣"},
      "3": {"zip": "303", "name": "湖口鄉", "city": "新竹縣"},
      "4": {"zip": "304", "name": "新豐鄉", "city": "新竹縣"},
      "5": {"zip": "305", "name": "新埔鎮", "city": "新竹縣"},
      "6": {"zip": "306", "name": "關西鎮", "city": "新竹縣"},
      "7": {"zip": "307", "name": "芎林鄉", "city": "新竹縣"},
      "8": {"zip": "308", "name": "寶山鄉", "city": "新竹縣"}
    },
    "1": {
      "0": {"zip": "310", "name": "竹東鎮", "city": "新竹縣"},
      "1": {"zip": "311", "name": "五峰鄉", "city": "新竹縣"},
      "2": {"zip": "312", "name": "橫山鄉", "city": "新竹縣"},
      "3": {"zip": "313", "name": "尖石鄉", "city": "新竹縣"},
      "4": {"zip": "314", "name": "北埔鄉", "city": "新竹縣"},
      "5": {"zip": "315", "name": "峨眉鄉", "city": "新竹縣"}
    },
    "2": {
      "0": {"zip": "320", "name": "中壢區", "city": "桃園市"},
      "4": {"zip": "324", "name": "平鎮區", "city": "桃園市"},
      "5": {"zip": "325", "name": "龍潭區", "city": "桃園市"},
      "6": {"zip": "326", "name": "楊梅區", "city": "桃園市"},
      "7": {"zip": "327", "name": "新屋區", "city": "桃園市"},
      "8": {"zip": "328", "name": "觀音區", "city": "桃園市"}
    },
    "3": {
      "0": {"zip": "330", "name": "桃園區", "city": "桃園市"},
      "3": {"zip": "333", "name": "龜山區", "city": "桃園市"},
      "4": {"zip": "334", "name": "八德區", "city": "桃園市"},
      "5": {"zip": "335", "name": "大溪區", "city": "桃園市"},
      "6": {"zip": "336", "name": "復興區", "city": "桃園市"},
      "7": {"zip": "337", "name": "大園區", "city": "桃園市"},
      "8": {"zip": "338", "name": "蘆竹區", "city": "桃園市"}
    },
    "5": {
      "0": {"zip": "350", "name": "竹南鎮", "city": "苗栗縣"},
      "1": {"zip": "351", "name": "頭份市", "city": "苗栗縣"},
      "2": {"zip": "352", "name": "三灣鄉", "city": "苗栗縣"},
      "3": {"zip": "353", "name": "南庄鄉", "city": "苗栗縣"},
      "4": {"zip": "354", "name": "獅潭鄉", "city": "苗栗縣"},
      "6": {"zip": "356", "name": "後龍鎮", "city": "苗栗縣"},
      "7": {"zip": "357", "name": "通霄鎮", "city": "苗栗縣"},
      "8": {"zip": "358", "name": "苑裡鎮", "city": "苗栗縣"}
    },
    "6": {
      "0": {"zip": "360", "name": "苗栗市", "city": "苗栗縣"},
      "1": {"zip": "361", "name": "造橋鄉", "city": "苗栗縣"},
      "2": {"zip": "362", "name": "頭屋鄉", "city": "苗栗縣"},
      "3": {"zip": "363", "name": "公館鄉", "city": "苗栗縣"},
      "4": {"zip": "364", "name": "大湖鄉", "city": "苗栗縣"},
      "5": {"zip": "365", "name": "泰安鄉", "city": "苗栗縣"},
      "6": {"zip": "366", "name": "銅鑼鄉", "city": "苗栗縣"},
      "7": {"zip": "367", "name": "三義鄉", "city": "苗栗縣"},
      "8": {"zip": "368", "name": "西湖鄉", "city": "苗栗縣"},
      "9": {"zip": "369", "name": "卓蘭鎮", "city": "苗栗縣"}
    }
  },
  "4": {
    "0": {
      "0": {"zip": "400", "name": "中區", "city": "臺中市"},
      "1": {"zip": "401", "name": "東區", "city": "臺中市"},
      "2": {"zip": "402", "name": "南區", "city": "臺中市"},
      "3": {"zip": "403", "name": "西區", "city": "臺中市"},
      "4": {"zip": "404", "name": "北區", "city": "臺中市"},
      "6": {"zip": "406", "name": "北屯區", "city": "臺中市"},
      "7": {"zip": "407", "name": "西屯區", "city": "臺中市"},
      "8": {"zip": "408", "name": "南屯區", "city": "臺中市"}
    },
    "1": {
      "1": {"zip": "411", "name": "太平區", "city": "臺中市"},
      "2": {"zip": "412", "name": "大里區", "city": "臺中市"},
      "3": {"zip": "413", "name": "霧峰區", "city": "臺中市"},
      "4": {"zip": "414", "name": "烏日區", "city": "臺中市"}
    },
    "2": {
      "0": {"zip": "420", "name": "豐原區", "city": "臺中市"},
      "1": {"zip": "421", "name": "后里區", "city": "臺中市"},
      "2": {"zip": "422", "name": "石岡區", "city": "臺中市"},
      "3": {"zip": "423", "name": "東勢區", "city": "臺中市"},
      "4": {"zip": "424", "name": "和平區", "city": "臺中市"},
      "6": {"zip": "426", "name": "新社區", "city": "臺中市"},
      "7": {"zip": "427", "name": "潭子區", "city": "臺中市"},
      "8": {"zip": "428", "name": "大雅區", "city": "臺中市"},
      "9": {"zip": "429", "name": "神岡區", "city": "臺中市"}
    },
    "3": {
      "2": {"zip": "432", "name": "大肚區", "city": "臺中市"},
      "3": {"zip": "433", "name": "沙鹿區", "city": "臺中市"},
      "4": {"zip": "434", "name": "龍井區", "city": "臺中市"},
      "5": {"zip": "435", "name": "梧棲區", "city": "臺中市"},
      "6": {"zip": "436", "name": "清水區", "city": "臺中市"},
      "7": {"zip": "437", "name": "大甲區", "city": "臺中市"},
      "8": {"zip": "438", "name": "外埔區", "city": "臺中市"},
      "9": {"zip": "439", "name": "大安區", "city": "臺中市"}
    }
  },
  "5": {
    "0": {
      "0": {"zip": "500", "name": "彰化市", "city": "彰化縣"},
      "2": {"zip": "502", "name": "芬園鄉", "city": "彰化縣"},
      "3": {"zip": "503", "name": "花壇鄉", "city": "彰化縣"},
      "4": {"zip": "504", "name": "秀水鄉", "city": "彰化縣"},
      "5": {"zip": "505", "name": "鹿港鎮", "city": "彰化縣"},
      "6": {"zip": "506", "name": "福興鄉", "city": "彰化縣"},
      "7": {"zip": "507", "name": "線西鄉", "city": "彰化縣"},
      "8": {"zip": "508", "name": "和美鎮", "city": "彰化縣"},
      "9": {"zip": "509", "name": "伸港鄉", "city": "彰化縣"}
    },
    "1": {
      "0": {"zip": "510", "name": "員林市", "city": "彰化縣"},
      "1": {"zip": "511", "name": "社頭鄉", "city": "彰化縣"},
      "2": {"zip": "512", "name": "永靖鄉", "city": "彰化縣"},
      "3": {"zip": "513", "name": "埔心鄉", "city": "彰化縣"},
      "4": {"zip": "514", "name": "溪湖鎮", "city": "彰化縣"},
      "5": {"zip": "515", "name": "大村鄉", "city": "彰化縣"},
      "6": {"zip": "516", "name": "埔鹽鄉", "city": "彰化縣"}
    },
    "2": {
      "0": {"zip": "520", "name": "田中鎮", "city": "彰化縣"},
      "1": {"zip": "521", "name": "北斗鎮", "city": "彰化縣"},
      "2": {"zip": "522", "name": "田尾鄉", "city": "彰化縣"},
      "3": {"zip": "523", "name": "埤頭鄉", "city": "彰化縣"},
      "4": {"zip": "524", "name": "溪州鄉", "city": "彰化縣"},
      "5": {"zip": "525", "name": "竹塘鄉", "city": "彰化縣"},
      "6": {"zip": "526", "name": "二林鎮", "city": "彰化縣"},
      "7": {"zip": "527", "name": "大城鄉", "city": "彰化縣"},
      "8": {"zip": "528", "name": "芳苑鄉", "city": "彰化縣"}
    },
    "3": {
      "0": {"zip": "530", "name": "二水鄉", "city": "彰化縣"}
    },
    "4": {
      "0": {"zip": "540", "name": "南投市", "city": "南投縣"},
      "1": {"zip": "541", "name": "中寮鄉", "city": "南投縣"},
      "2": {"zip": "542", "name": "草屯鎮", "city": "南投縣"},
      "4": {"zip": "544", "name": "國姓鄉", "city": "南投縣"},
      "5": {"zip": "545", "name": "埔里鎮", "city": "南投縣"},
      "6": {"zip": "546", "name": "仁愛鄉", "city": "南投縣"}
    },
    "5": {
      "1": {"zip": "551", "name": "名間鄉", "city": "南投縣"},
      "2": {"zip": "552", "name": "集集鎮", "city": "南投縣"},
      "3": {"zip": "553", "name": "水里鄉", "city": "南投縣"},
      "5": {"zip": "555", "name": "魚池鄉", "city": "南投縣"},
      "6": {"zip": "556", "name": "信義鄉", "city": "南投縣"},
      "7": {"zip": "557", "name": "竹山鎮", "city": "南投縣"},
      "8": {"zip": "558", "name": "鹿谷鄉", "city": "南投縣"}
    }
  },
  "6": {
    "0": {
      "0": {"zip": "600", "name": "西區/東區", "city": "嘉義市"},
      "2": {"zip": "602", "name": "番路鄉", "city": "嘉義縣"},
      "3": {"zip": "603", "name": "梅山鄉", "city": "嘉義縣"},
      "4": {"zip": "604", "name": "竹崎鄉", "city": "嘉義縣"},
      "5": {"zip": "605", "name": "阿里山鄉", "city": "嘉義縣"},
      "6": {"zip": "606", "name": "中埔鄉", "city": "嘉義縣"},
      "7": {"zip": "607", "name": "大埔鄉", "city": "嘉義縣"},
      "8": {"zip": "608", "name": "水上鄉", "city": "嘉義縣"}
    },
    "1": {
      "1": {"zip": "611", "name": "鹿草鄉", "city": "嘉義縣"},
      "2": {"zip": "612", "name": "太保市", "city": "嘉義縣"},
      "3": {"zip": "613", "name": "朴子市", "city": "嘉義縣"},
      "4": {"zip": "614", "name": "東石鄉", "city": "嘉義縣"},
      "5": {"zip": "615", "name": "六腳鄉", "city": "嘉義縣"},
      "6": {"zip": "616", "name": "新港鄉", "city": "嘉義縣"}
    },
    "2": {
      "1": {"zip": "621", "name": "民雄鄉", "city": "嘉義縣"},
      "2": {"zip": "622", "name": "大林鎮", "city": "嘉義縣"},
      "3": {"zip": "623", "name": "溪口鄉", "city": "嘉義縣"},
      "4": {"zip": "624", "name": "義竹鄉", "city": "嘉義縣"},
      "5": {"zip": "625", "name": "布袋鎮", "city": "嘉義縣"}
    },
    "3": {
      "0": {"zip": "630", "name": "斗南鎮", "city": "雲林縣"},
      "1": {"zip": "631", "name": "大埤鄉", "city": "雲林縣"},
      "2": {"zip": "632", "name": "虎尾鎮", "city": "雲林縣"},
      "3": {"zip": "633", "name": "土庫鎮", "city": "雲林縣"},
      "4": {"zip": "634", "name": "褒忠鄉", "city": "雲林縣"},
      "5": {"zip": "635", "name": "東勢鄉", "city": "雲林縣"},
      "6": {"zip": "636", "name": "臺西鄉", "city": "雲林縣"},
      "7": {"zip": "637", "name": "崙背鄉", "city": "雲林縣"},
      "8": {"zip": "638", "name": "麥寮鄉", "city": "雲林縣"}
    },
    "4": {
      "0": {"zip": "640", "name": "斗六市", "city": "雲林縣"},
      "3": {"zip": "643", "name": "林內鄉", "city": "雲林縣"},
      "6": {"zip": "646", "name": "古坑鄉", "city": "雲林縣"},
      "7": {"zip": "647", "name": "莿桐鄉", "city": "雲林縣"},
      "8": {"zip": "648", "name": "西螺鎮", "city": "雲林縣"},
      "9": {"zip": "649", "name": "二崙鄉", "city": "雲林縣"}
    },
    "5": {
      "1": {"zip": "651", "name": "北港鎮", "city": "雲林縣"},
      "2": {"zip": "652", "name": "水林鄉", "city": "雲林縣"},
      "3": {"zip": "653", "name": "口湖鄉", "city": "雲林縣"},
      "4": {"zip": "654", "name": "四湖鄉", "city": "雲林縣"},
      "5": {"zip": "655", "name": "元長鄉", "city": "雲林縣"}
    }
  },
  "7": {
    "0": {
      "0": {"zip": "700", "name": "中西區", "city": "臺南市"},
      "1": {"zip": "701", "name": "東區", "city": "臺南市"},
      "2": {"zip": "702", "name": "南區", "city": "臺南市"},
      "4": {"zip": "704", "name": "北區", "city": "臺南市"},
      "8": {"zip": "708", "name": "安平區", "city": "臺南市"},
      "9": {"zip": "709", "name": "安南區", "city": "臺南市"}
    },
    "1": {
      "0": {"zip": "710", "name": "永康區", "city": "臺南市"},
      "1": {"zip": "711", "name": "歸仁區", "city": "臺南市"},
      "2": {"zip": "712", "name": "新化區", "city": "臺南市"},
      "3": {"zip": "713", "name": "左鎮區", "city": "臺南市"},
      "4": {"zip": "714", "name": "玉井區", "city": "臺南市"},
      "5": {"zip": "715", "name": "楠西區", "city": "臺南市"},
      "6": {"zip": "716", "name": "南化區", "city": "臺南市"},
      "7": {"zip": "717", "name": "仁德區", "city": "臺南市"},
      "8": {"zip": "718", "name": "關廟區", "city": "臺南市"},
      "9": {"zip": "719", "name": "龍崎區", "city": "臺南市"}
    },
    "2": {
      "0": {"zip": "720", "name": "官田區", "city": "臺南市"},
      "1": {"zip": "721", "name": "麻豆區", "city": "臺南市"},
      "2": {"zip": "722", "name": "佳里區", "city": "臺南市"},
      "3": {"zip": "723", "name": "西港區", "city": "臺南市"},
      "4": {"zip": "724", "name": "七股區", "city": "臺南市"},
      "5": {"zip": "725", "name": "將軍區", "city": "臺南市"},
      "6": {"zip": "726", "name": "學甲區", "city": "臺南市"},
      "7": {"zip": "727", "name": "北門區", "city": "臺南市"}
    },
    "3": {
      "0": {"zip": "730", "name": "新營區", "city": "臺南市"},
      "1": {"zip": "731", "name": "後壁區", "city": "臺南市"},
      "2": {"zip": "732", "name": "白河區", "city": "臺南市"},
      "3": {"zip": "733", "name": "東山區", "city": "臺南市"},
      "4": {"zip": "734", "name": "六甲區", "city": "臺南市"},
      "5": {"zip": "735", "name": "下營區", "city": "臺南市"},
      "6": {"zip": "736", "name": "柳營區", "city": "臺南市"},
      "7": {"zip": "737", "name": "鹽水區", "city": "臺南市"}
    },
    "4": {
      "1": {"zip": "741", "name": "善化區", "city": "臺南市"},
      "4": {"zip": "744", "name": "新市區", "city": "臺南市"},
      "2": {"zip": "742", "name": "大內區", "city": "臺南市"},
      "3": {"zip": "743", "name": "山上區", "city": "臺南市"},
      "5": {"zip": "745", "name": "安定區", "city": "臺南市"}
    }
  },
  "8": {
    "0": {
      "0": {"zip": "800", "name": "新興區", "city": "高雄市"},
      "1": {"zip": "801", "name": "前金區", "city": "高雄市"},
      "2": {"zip": "802", "name": "苓雅區", "city": "高雄市"},
      "3": {"zip": "803", "name": "鹽埕區", "city": "高雄市"},
      "4": {"zip": "804", "name": "鼓山區", "city": "高雄市"},
      "5": {"zip": "805", "name": "旗津區", "city": "高雄市"},
      "6": {"zip": "806", "name": "前鎮區", "city": "高雄市"},
      "7": {"zip": "807", "name": "三民區", "city": "高雄市"}
    },
    "1": {
      "1": {"zip": "811", "name": "楠梓區", "city": "高雄市"},
      "2": {"zip": "812", "name": "小港區", "city": "高雄市"},
      "3": {"zip": "813", "name": "左營區", "city": "高雄市"},
      "4": {"zip": "814", "name": "仁武區", "city": "高雄市"},
      "5": {"zip": "815", "name": "大社區", "city": "高雄市"},
      "7": {"zip": "817", "name": "東沙群島", "city": "南海諸島"},
      "9": {"zip": "819", "name": "南沙群島", "city": "南海諸島"}
    },
    "2": {
      "0": {"zip": "820", "name": "岡山區", "city": "高雄市"},
      "1": {"zip": "821", "name": "路竹區", "city": "高雄市"},
      "2": {"zip": "822", "name": "阿蓮區", "city": "高雄市"},
      "3": {"zip": "823", "name": "田寮區", "city": "高雄市"},
      "4": {"zip": "824", "name": "燕巢區", "city": "高雄市"},
      "5": {"zip": "825", "name": "橋頭區", "city": "高雄市"},
      "6": {"zip": "826", "name": "梓官區", "city": "高雄市"},
      "7": {"zip": "827", "name": "彌陀區", "city": "高雄市"},
      "8": {"zip": "828", "name": "永安區", "city": "高雄市"},
      "9": {"zip": "829", "name": "湖內區", "city": "高雄市"}
    },
    "3": {
      "0": {"zip": "830", "name": "鳳山區", "city": "高雄市"},
      "1": {"zip": "831", "name": "大寮區", "city": "高雄市"},
      "2": {"zip": "832", "name": "林園區", "city": "高雄市"},
      "3": {"zip": "833", "name": "鳥松區", "city": "高雄市"}
    },
    "4": {
      "0": {"zip": "840", "name": "大樹區", "city": "高雄市"},
      "2": {"zip": "842", "name": "旗山區", "city": "高雄市"},
      "3": {"zip": "843", "name": "美濃區", "city": "高雄市"},
      "4": {"zip": "844", "name": "六龜區", "city": "高雄市"},
      "5": {"zip": "845", "name": "內門區", "city": "高雄市"},
      "6": {"zip": "846", "name": "杉林區", "city": "高雄市"},
      "7": {"zip": "847", "name": "甲仙區", "city": "高雄市"},
      "8": {"zip": "848", "name": "桃源區", "city": "高雄市"},
      "9": {"zip": "849", "name": "那瑪夏區", "city": "高雄市"}
    },
    "5": {
      "1": {"zip": "851", "name": "茂林區", "city": "高雄市"},
      "2": {"zip": "852", "name": "茄萣區", "city": "高雄市"}
    },
    "8": {
      "0": {"zip": "880", "name": "馬公市", "city": "澎湖縣"},
      "1": {"zip": "881", "name": "西嶼鄉", "city": "澎湖縣"},
      "2": {"zip": "882", "name": "望安鄉", "city": "澎湖縣"},
      "3": {"zip": "883", "name": "七美鄉", "city": "澎湖縣"},
      "4": {"zip": "884", "name": "白沙鄉", "city": "澎湖縣"},
      "5": {"zip": "885", "name": "湖西鄉", "city": "澎湖縣"}
    },
    "9": {
      "0": {"zip": "890", "name": "金沙鎮", "city": "金門縣"},
      "1": {"zip": "891", "name": "金湖鎮", "city": "金門縣"},
      "2": {"zip": "892", "name": "金寧鄉", "city": "金門縣"},
      "3": {"zip": "893", "name": "金城鎮", "city": "金門縣"},
      "4": {"zip": "894", "name": "烈嶼鄉", "city": "金門縣"},
      "6": {"zip": "896", "name": "烏坵鄉", "city": "金門縣"}
    }
  },
  "9": {
    "0": {
      "0": {"zip": "900", "name": "屏東市", "city": "屏東縣"},
      "1": {"zip": "901", "name": "三地門鄉", "city": "屏東縣"},
      "2": {"zip": "902", "name": "霧臺鄉", "city": "屏東縣"},
      "3": {"zip": "903", "name": "瑪家鄉", "city": "屏東縣"},
      "4": {"zip": "904", "name": "九如鄉", "city": "屏東縣"},
      "5": {"zip": "905", "name": "里港鄉", "city": "屏東縣"},
      "6": {"zip": "906", "name": "高樹鄉", "city": "屏東縣"},
      "7": {"zip": "907", "name": "鹽埔鄉", "city": "屏東縣"},
      "8": {"zip": "908", "name": "長治鄉", "city": "屏東縣"},
      "9": {"zip": "909", "name": "麟洛鄉", "city": "屏東縣"}
    },
    "1": {
      "1": {"zip": "911", "name": "竹田鄉", "city": "屏東縣"},
      "2": {"zip": "912", "name": "內埔鄉", "city": "屏東縣"},
      "3": {"zip": "913", "name": "萬丹鄉", "city": "屏東縣"},
      "0": {"zip": "920", "name": "潮州鎮", "city": "屏東縣"}
    },
    "2": {
      "1": {"zip": "921", "name": "泰武鄉", "city": "屏東縣"},
      "2": {"zip": "922", "name": "來義鄉", "city": "屏東縣"},
      "3": {"zip": "923", "name": "萬巒鄉", "city": "屏東縣"},
      "4": {"zip": "924", "name": "崁頂鄉", "city": "屏東縣"},
      "5": {"zip": "925", "name": "新埤鄉", "city": "屏東縣"},
      "6": {"zip": "926", "name": "南州鄉", "city": "屏東縣"},
      "7": {"zip": "927", "name": "林邊鄉", "city": "屏東縣"},
      "8": {"zip": "928", "name": "東港鎮", "city": "屏東縣"},
      "9": {"zip": "929", "name": "琉球鄉", "city": "屏東縣"}
    },
    "3": {
      "1": {"zip": "931", "name": "佳冬鄉", "city": "屏東縣"},
      "2": {"zip": "932", "name": "新園鄉", "city": "屏東縣"}
    },
    "4": {
      "0": {"zip": "940", "name": "枋寮鄉", "city": "屏東縣"},
      "1": {"zip": "941", "name": "枋山鄉", "city": "屏東縣"},
      "2": {"zip": "942", "name": "春日鄉", "city": "屏東縣"},
      "3": {"zip": "943", "name": "獅子鄉", "city": "屏東縣"},
      "4": {"zip": "944", "name": "車城鄉", "city": "屏東縣"},
      "5": {"zip": "945", "name": "牡丹鄉", "city": "屏東縣"},
      "6": {"zip": "946", "name": "恆春鎮", "city": "屏東縣"},
      "7": {"zip": "947", "name": "滿州鄉", "city": "屏東縣"}
    },
    "5": {
      "0": {"zip": "950", "name": "臺東市", "city": "臺東縣"},
      "1": {"zip": "951", "name": "綠島鄉", "city": "臺東縣"},
      "2": {"zip": "952", "name": "蘭嶼鄉", "city": "臺東縣"},
      "3": {"zip": "953", "name": "延平鄉", "city": "臺東縣"},
      "4": {"zip": "954", "name": "卑南鄉", "city": "臺東縣"},
      "5": {"zip": "955", "name": "鹿野鄉", "city": "臺東縣"},
      "6": {"zip": "956", "name": "關山鎮", "city": "臺東縣"},
      "7": {"zip": "957", "name": "海端鄉", "city": "臺東縣"},
      "8": {"zip": "958", "name": "池上鄉", "city": "臺東縣"},
      "9": {"zip": "959", "name": "東河鄉", "city": "臺東縣"}
    },
    "6": {
      "1": {"zip": "961", "name": "成功鎮", "city": "臺東縣"},
      "2": {"zip": "962", "name": "長濱鄉", "city": "臺東縣"},
      "3": {"zip": "963", "name": "太麻里鄉", "city": "臺東縣"},
      "4": {"zip": "964", "name": "金峰鄉", "city": "臺東縣"},
      "5": {"zip": "965", "name": "大武鄉", "city": "臺東縣"},
      "6": {"zip": "966", "name": "達仁鄉", "city": "臺東縣"}
    },
    "7": {
      "0": {"zip": "970", "name": "花蓮市", "city": "花蓮縣"},
      "1": {"zip": "971", "name": "新城鄉", "city": "花蓮縣"},
      "2": {"zip": "972", "name": "秀林鄉", "city": "花蓮縣"},
      "3": {"zip": "973", "name": "吉安鄉", "city": "花蓮縣"},
      "4": {"zip": "974", "name": "壽豐鄉", "city": "花蓮縣"},
      "5": {"zip": "975", "name": "鳳林鎮", "city": "花蓮縣"},
      "6": {"zip": "976", "name": "光復鄉", "city": "花蓮縣"},
      "7": {"zip": "977", "name": "豐濱鄉", "city": "花蓮縣"},
      "8": {"zip": "978", "name": "瑞穗鄉", "city": "花蓮縣"},
      "9": {"zip": "979", "name": "萬榮鄉", "city": "花蓮縣"}
    },
    "8": {
      "1": {"zip": "981", "name": "玉里鎮", "city": "花蓮縣"},
      "2": {"zip": "982", "name": "卓溪鄉", "city": "花蓮縣"},
      "3": {"zip": "983", "name": "富里鄉", "city": "花蓮縣"}
    }
  }
};

const cityData = [
  {
    "districts": [
      {"zip": "100", "name": "中正區"},
      {"zip": "103", "name": "大同區"},
      {"zip": "104", "name": "中山區"},
      {"zip": "105", "name": "松山區"},
      {"zip": "106", "name": "大安區"},
      {"zip": "108", "name": "萬華區"},
      {"zip": "110", "name": "信義區"},
      {"zip": "111", "name": "士林區"},
      {"zip": "112", "name": "北投區"},
      {"zip": "114", "name": "內湖區"},
      {"zip": "115", "name": "南港區"},
      {"zip": "116", "name": "文山區"},
    ],
    "name": "臺北市"
  },
  {
    "districts": [
      {"zip": "200", "name": "仁愛區"},
      {"zip": "201", "name": "信義區"},
      {"zip": "202", "name": "中正區"},
      {"zip": "203", "name": "中山區"},
      {"zip": "204", "name": "安樂區"},
      {"zip": "205", "name": "暖暖區"},
      {"zip": "206", "name": "七堵區"}
    ],
    "name": "基隆市"
  },
  {
    "districts": [
      {"zip": "207", "name": "萬里區"},
      {"zip": "208", "name": "金山區"},
      {"zip": "220", "name": "板橋區"},
      {"zip": "221", "name": "汐止區"},
      {"zip": "222", "name": "深坑區"},
      {"zip": "223", "name": "石碇區"},
      {"zip": "224", "name": "瑞芳區"},
      {"zip": "226", "name": "平溪區"},
      {"zip": "227", "name": "雙溪區"},
      {"zip": "228", "name": "貢寮區"},
      {"zip": "231", "name": "新店區"},
      {"zip": "232", "name": "坪林區"},
      {"zip": "233", "name": "烏來區"},
      {"zip": "234", "name": "永和區"},
      {"zip": "235", "name": "中和區"},
      {"zip": "236", "name": "土城區"},
      {"zip": "237", "name": "三峽區"},
      {"zip": "238", "name": "樹林區"},
      {"zip": "239", "name": "鶯歌區"},
      {"zip": "241", "name": "三重區"},
      {"zip": "242", "name": "新莊區"},
      {"zip": "243", "name": "泰山區"},
      {"zip": "244", "name": "林口區"},
      {"zip": "247", "name": "蘆洲區"},
      {"zip": "248", "name": "五股區"},
      {"zip": "249", "name": "八里區"},
      {"zip": "251", "name": "淡水區"},
      {"zip": "252", "name": "三芝區"},
      {"zip": "253", "name": "石門區"}
    ],
    "name": "新北市"
  },
  {
    "districts": [
      {"zip": "209", "name": "南竿鄉"},
      {"zip": "210", "name": "北竿鄉"},
      {"zip": "211", "name": "莒光鄉"},
      {"zip": "212", "name": "東引鄉"}
    ],
    "name": "連江縣"
  },
  {
    "districts": [
      {"zip": "260", "name": "宜蘭市"},
      {"zip": "263", "name": "壯圍鄉"},
      {"zip": "261", "name": "頭城鎮"},
      {"zip": "262", "name": "礁溪鄉"},
      {"zip": "264", "name": "員山鄉"},
      {"zip": "265", "name": "羅東鎮"},
      {"zip": "266", "name": "三星鄉"},
      {"zip": "267", "name": "大同鄉"},
      {"zip": "268", "name": "五結鄉"},
      {"zip": "269", "name": "冬山鄉"},
      {"zip": "270", "name": "蘇澳鎮"},
      {"zip": "272", "name": "南澳鄉"},
      {"zip": "290", "name": "釣魚臺"}
    ],
    "name": "宜蘭縣"
  },
  {
    "districts": [
      {"zip": "290", "name": "釣魚臺"}
    ],
    "name": "釣魚臺"
  },
  {
    "districts": [
      {"zip": "300", "name": "東區"},
      {"zip": "300", "name": "北區"},
      {"zip": "300", "name": "香山區"}
    ],
    "name": "新竹市"
  },
  {
    "districts": [
      {"zip": "308", "name": "寶山鄉"},
      {"zip": "302", "name": "竹北市"},
      {"zip": "303", "name": "湖口鄉"},
      {"zip": "304", "name": "新豐鄉"},
      {"zip": "305", "name": "新埔鎮"},
      {"zip": "306", "name": "關西鎮"},
      {"zip": "307", "name": "芎林鄉"},
      {"zip": "310", "name": "竹東鎮"},
      {"zip": "311", "name": "五峰鄉"},
      {"zip": "312", "name": "橫山鄉"},
      {"zip": "313", "name": "尖石鄉"},
      {"zip": "314", "name": "北埔鄉"},
      {"zip": "315", "name": "峨眉鄉"}
    ],
    "name": "新竹縣"
  },
  {
    "districts": [
      {"zip": "320", "name": "中壢區"},
      {"zip": "324", "name": "平鎮區"},
      {"zip": "325", "name": "龍潭區"},
      {"zip": "326", "name": "楊梅區"},
      {"zip": "327", "name": "新屋區"},
      {"zip": "328", "name": "觀音區"},
      {"zip": "330", "name": "桃園區"},
      {"zip": "333", "name": "龜山區"},
      {"zip": "334", "name": "八德區"},
      {"zip": "335", "name": "大溪區"},
      {"zip": "336", "name": "復興區"},
      {"zip": "337", "name": "大園區"},
      {"zip": "338", "name": "蘆竹區"}
    ],
    "name": "桃園市"
  },
  {
    "districts": [
      {"zip": "350", "name": "竹南鎮"},
      {"zip": "351", "name": "頭份市"},
      {"zip": "352", "name": "三灣鄉"},
      {"zip": "353", "name": "南庄鄉"},
      {"zip": "354", "name": "獅潭鄉"},
      {"zip": "356", "name": "後龍鎮"},
      {"zip": "357", "name": "通霄鎮"},
      {"zip": "358", "name": "苑裡鎮"},
      {"zip": "360", "name": "苗栗市"},
      {"zip": "361", "name": "造橋鄉"},
      {"zip": "362", "name": "頭屋鄉"},
      {"zip": "363", "name": "公館鄉"},
      {"zip": "364", "name": "大湖鄉"},
      {"zip": "365", "name": "泰安鄉"},
      {"zip": "366", "name": "銅鑼鄉"},
      {"zip": "367", "name": "三義鄉"},
      {"zip": "368", "name": "西湖鄉"},
      {"zip": "369", "name": "卓蘭鎮"}
    ],
    "name": "苗栗縣"
  },
  {
    "districts": [
      {"zip": "400", "name": "中區"},
      {"zip": "401", "name": "東區"},
      {"zip": "402", "name": "南區"},
      {"zip": "403", "name": "西區"},
      {"zip": "404", "name": "北區"},
      {"zip": "406", "name": "北屯區"},
      {"zip": "407", "name": "西屯區"},
      {"zip": "408", "name": "南屯區"},
      {"zip": "411", "name": "太平區"},
      {"zip": "412", "name": "大里區"},
      {"zip": "413", "name": "霧峰區"},
      {"zip": "414", "name": "烏日區"},
      {"zip": "420", "name": "豐原區"},
      {"zip": "421", "name": "后里區"},
      {"zip": "422", "name": "石岡區"},
      {"zip": "423", "name": "東勢區"},
      {"zip": "424", "name": "和平區"},
      {"zip": "426", "name": "新社區"},
      {"zip": "427", "name": "潭子區"},
      {"zip": "428", "name": "大雅區"},
      {"zip": "429", "name": "神岡區"},
      {"zip": "432", "name": "大肚區"},
      {"zip": "433", "name": "沙鹿區"},
      {"zip": "434", "name": "龍井區"},
      {"zip": "435", "name": "梧棲區"},
      {"zip": "436", "name": "清水區"},
      {"zip": "437", "name": "大甲區"},
      {"zip": "438", "name": "外埔區"},
      {"zip": "439", "name": "大安區"}
    ],
    "name": "臺中市"
  },
  {
    "districts": [
      {"zip": "500", "name": "彰化市"},
      {"zip": "502", "name": "芬園鄉"},
      {"zip": "503", "name": "花壇鄉"},
      {"zip": "504", "name": "秀水鄉"},
      {"zip": "505", "name": "鹿港鎮"},
      {"zip": "506", "name": "福興鄉"},
      {"zip": "507", "name": "線西鄉"},
      {"zip": "508", "name": "和美鎮"},
      {"zip": "509", "name": "伸港鄉"},
      {"zip": "510", "name": "員林市"},
      {"zip": "511", "name": "社頭鄉"},
      {"zip": "512", "name": "永靖鄉"},
      {"zip": "513", "name": "埔心鄉"},
      {"zip": "514", "name": "溪湖鎮"},
      {"zip": "515", "name": "大村鄉"},
      {"zip": "516", "name": "埔鹽鄉"},
      {"zip": "520", "name": "田中鎮"},
      {"zip": "521", "name": "北斗鎮"},
      {"zip": "522", "name": "田尾鄉"},
      {"zip": "523", "name": "埤頭鄉"},
      {"zip": "524", "name": "溪州鄉"},
      {"zip": "525", "name": "竹塘鄉"},
      {"zip": "526", "name": "二林鎮"},
      {"zip": "527", "name": "大城鄉"},
      {"zip": "528", "name": "芳苑鄉"},
      {"zip": "530", "name": "二水鄉"}
    ],
    "name": "彰化縣"
  },
  {
    "districts": [
      {"zip": "540", "name": "南投市"},
      {"zip": "541", "name": "中寮鄉"},
      {"zip": "542", "name": "草屯鎮"},
      {"zip": "544", "name": "國姓鄉"},
      {"zip": "545", "name": "埔里鎮"},
      {"zip": "546", "name": "仁愛鄉"},
      {"zip": "551", "name": "名間鄉"},
      {"zip": "552", "name": "集集鎮"},
      {"zip": "553", "name": "水里鄉"},
      {"zip": "555", "name": "魚池鄉"},
      {"zip": "556", "name": "信義鄉"},
      {"zip": "557", "name": "竹山鎮"},
      {"zip": "558", "name": "鹿谷鄉"}
    ],
    "name": "南投縣"
  },
  {
    "districts": [
      {"zip": "600", "name": "西區"},
      {"zip": "600", "name": "東區"}
    ],
    "name": "嘉義市"
  },
  {
    "districts": [
      {"zip": "602", "name": "番路鄉"},
      {"zip": "603", "name": "梅山鄉"},
      {"zip": "604", "name": "竹崎鄉"},
      {"zip": "605", "name": "阿里山鄉"},
      {"zip": "606", "name": "中埔鄉"},
      {"zip": "607", "name": "大埔鄉"},
      {"zip": "608", "name": "水上鄉"},
      {"zip": "611", "name": "鹿草鄉"},
      {"zip": "612", "name": "太保市"},
      {"zip": "613", "name": "朴子市"},
      {"zip": "614", "name": "東石鄉"},
      {"zip": "615", "name": "六腳鄉"},
      {"zip": "616", "name": "新港鄉"},
      {"zip": "621", "name": "民雄鄉"},
      {"zip": "622", "name": "大林鎮"},
      {"zip": "623", "name": "溪口鄉"},
      {"zip": "624", "name": "義竹鄉"},
      {"zip": "625", "name": "布袋鎮"}
    ],
    "name": "嘉義縣"
  },
  {
    "districts": [
      {"zip": "630", "name": "斗南鎮"},
      {"zip": "631", "name": "大埤鄉"},
      {"zip": "632", "name": "虎尾鎮"},
      {"zip": "633", "name": "土庫鎮"},
      {"zip": "634", "name": "褒忠鄉"},
      {"zip": "635", "name": "東勢鄉"},
      {"zip": "636", "name": "臺西鄉"},
      {"zip": "637", "name": "崙背鄉"},
      {"zip": "638", "name": "麥寮鄉"},
      {"zip": "640", "name": "斗六市"},
      {"zip": "643", "name": "林內鄉"},
      {"zip": "646", "name": "古坑鄉"},
      {"zip": "647", "name": "莿桐鄉"},
      {"zip": "648", "name": "西螺鎮"},
      {"zip": "649", "name": "二崙鄉"},
      {"zip": "651", "name": "北港鎮"},
      {"zip": "652", "name": "水林鄉"},
      {"zip": "653", "name": "口湖鄉"},
      {"zip": "654", "name": "四湖鄉"},
      {"zip": "655", "name": "元長鄉"}
    ],
    "name": "雲林縣"
  },
  {
    "districts": [
      {"zip": "700", "name": "中西區"},
      {"zip": "701", "name": "東區"},
      {"zip": "702", "name": "南區"},
      {"zip": "704", "name": "北區"},
      {"zip": "708", "name": "安平區"},
      {"zip": "709", "name": "安南區"},
      {"zip": "710", "name": "永康區"},
      {"zip": "711", "name": "歸仁區"},
      {"zip": "712", "name": "新化區"},
      {"zip": "713", "name": "左鎮區"},
      {"zip": "714", "name": "玉井區"},
      {"zip": "715", "name": "楠西區"},
      {"zip": "716", "name": "南化區"},
      {"zip": "717", "name": "仁德區"},
      {"zip": "718", "name": "關廟區"},
      {"zip": "719", "name": "龍崎區"},
      {"zip": "720", "name": "官田區"},
      {"zip": "721", "name": "麻豆區"},
      {"zip": "722", "name": "佳里區"},
      {"zip": "723", "name": "西港區"},
      {"zip": "724", "name": "七股區"},
      {"zip": "725", "name": "將軍區"},
      {"zip": "726", "name": "學甲區"},
      {"zip": "727", "name": "北門區"},
      {"zip": "730", "name": "新營區"},
      {"zip": "731", "name": "後壁區"},
      {"zip": "732", "name": "白河區"},
      {"zip": "733", "name": "東山區"},
      {"zip": "734", "name": "六甲區"},
      {"zip": "735", "name": "下營區"},
      {"zip": "736", "name": "柳營區"},
      {"zip": "737", "name": "鹽水區"},
      {"zip": "741", "name": "善化區"},
      {"zip": "744", "name": "新市區"},
      {"zip": "742", "name": "大內區"},
      {"zip": "743", "name": "山上區"},
      {"zip": "745", "name": "安定區"}
    ],
    "name": "臺南市"
  },
  {
    "districts": [
      {"zip": "800", "name": "新興區"},
      {"zip": "801", "name": "前金區"},
      {"zip": "802", "name": "苓雅區"},
      {"zip": "803", "name": "鹽埕區"},
      {"zip": "804", "name": "鼓山區"},
      {"zip": "805", "name": "旗津區"},
      {"zip": "806", "name": "前鎮區"},
      {"zip": "807", "name": "三民區"},
      {"zip": "811", "name": "楠梓區"},
      {"zip": "812", "name": "小港區"},
      {"zip": "813", "name": "左營區"},
      {"zip": "814", "name": "仁武區"},
      {"zip": "815", "name": "大社區"},
      {"zip": "817", "name": "東沙群島"},
      {"zip": "819", "name": "南沙群島"},
      {"zip": "820", "name": "岡山區"},
      {"zip": "821", "name": "路竹區"},
      {"zip": "822", "name": "阿蓮區"},
      {"zip": "823", "name": "田寮區"},
      {"zip": "824", "name": "燕巢區"},
      {"zip": "825", "name": "橋頭區"},
      {"zip": "826", "name": "梓官區"},
      {"zip": "827", "name": "彌陀區"},
      {"zip": "828", "name": "永安區"},
      {"zip": "829", "name": "湖內區"},
      {"zip": "830", "name": "鳳山區"},
      {"zip": "831", "name": "大寮區"},
      {"zip": "832", "name": "林園區"},
      {"zip": "833", "name": "鳥松區"},
      {"zip": "840", "name": "大樹區"},
      {"zip": "842", "name": "旗山區"},
      {"zip": "843", "name": "美濃區"},
      {"zip": "844", "name": "六龜區"},
      {"zip": "845", "name": "內門區"},
      {"zip": "846", "name": "杉林區"},
      {"zip": "847", "name": "甲仙區"},
      {"zip": "848", "name": "桃源區"},
      {"zip": "849", "name": "那瑪夏區"},
      {"zip": "851", "name": "茂林區"},
      {"zip": "852", "name": "茄萣區"}
    ],
    "name": "高雄市"
  },
  {
    "districts": [
      {"zip": "817", "name": "東沙群島"},
      {"zip": "819", "name": "南沙群島"}
    ],
    "name": "南海諸島"
  },
  {
    "districts": [
      {"zip": "880", "name": "馬公市"},
      {"zip": "881", "name": "西嶼鄉"},
      {"zip": "882", "name": "望安鄉"},
      {"zip": "883", "name": "七美鄉"},
      {"zip": "884", "name": "白沙鄉"},
      {"zip": "885", "name": "湖西鄉"}
    ],
    "name": "澎湖縣"
  },
  {
    "districts": [
      {"zip": "890", "name": "金沙鎮"},
      {"zip": "891", "name": "金湖鎮"},
      {"zip": "892", "name": "金寧鄉"},
      {"zip": "893", "name": "金城鎮"},
      {"zip": "894", "name": "烈嶼鄉"},
      {"zip": "896", "name": "烏坵鄉"}
    ],
    "name": "金門縣"
  },
  {
    "districts": [
      {"zip": "900", "name": "屏東市"},
      {"zip": "901", "name": "三地門鄉"},
      {"zip": "902", "name": "霧臺鄉"},
      {"zip": "903", "name": "瑪家鄉"},
      {"zip": "904", "name": "九如鄉"},
      {"zip": "905", "name": "里港鄉"},
      {"zip": "906", "name": "高樹鄉"},
      {"zip": "907", "name": "鹽埔鄉"},
      {"zip": "908", "name": "長治鄉"},
      {"zip": "909", "name": "麟洛鄉"},
      {"zip": "911", "name": "竹田鄉"},
      {"zip": "912", "name": "內埔鄉"},
      {"zip": "913", "name": "萬丹鄉"},
      {"zip": "920", "name": "潮州鎮"},
      {"zip": "921", "name": "泰武鄉"},
      {"zip": "922", "name": "來義鄉"},
      {"zip": "923", "name": "萬巒鄉"},
      {"zip": "924", "name": "崁頂鄉"},
      {"zip": "925", "name": "新埤鄉"},
      {"zip": "926", "name": "南州鄉"},
      {"zip": "927", "name": "林邊鄉"},
      {"zip": "928", "name": "東港鎮"},
      {"zip": "929", "name": "琉球鄉"},
      {"zip": "931", "name": "佳冬鄉"},
      {"zip": "932", "name": "新園鄉"},
      {"zip": "940", "name": "枋寮鄉"},
      {"zip": "941", "name": "枋山鄉"},
      {"zip": "942", "name": "春日鄉"},
      {"zip": "943", "name": "獅子鄉"},
      {"zip": "944", "name": "車城鄉"},
      {"zip": "945", "name": "牡丹鄉"},
      {"zip": "946", "name": "恆春鎮"},
      {"zip": "947", "name": "滿州鄉"}
    ],
    "name": "屏東縣"
  },
  {
    "districts": [
      {"zip": "950", "name": "臺東市"},
      {"zip": "951", "name": "綠島鄉"},
      {"zip": "952", "name": "蘭嶼鄉"},
      {"zip": "953", "name": "延平鄉"},
      {"zip": "954", "name": "卑南鄉"},
      {"zip": "955", "name": "鹿野鄉"},
      {"zip": "956", "name": "關山鎮"},
      {"zip": "957", "name": "海端鄉"},
      {"zip": "958", "name": "池上鄉"},
      {"zip": "959", "name": "東河鄉"},
      {"zip": "961", "name": "成功鎮"},
      {"zip": "962", "name": "長濱鄉"},
      {"zip": "963", "name": "太麻里鄉"},
      {"zip": "964", "name": "金峰鄉"},
      {"zip": "965", "name": "大武鄉"},
      {"zip": "966", "name": "達仁鄉"}
    ],
    "name": "臺東縣"
  },
  {
    "districts": [
      {"zip": "970", "name": "花蓮市"},
      {"zip": "971", "name": "新城鄉"},
      {"zip": "972", "name": "秀林鄉"},
      {"zip": "973", "name": "吉安鄉"},
      {"zip": "974", "name": "壽豐鄉"},
      {"zip": "975", "name": "鳳林鎮"},
      {"zip": "976", "name": "光復鄉"},
      {"zip": "977", "name": "豐濱鄉"},
      {"zip": "978", "name": "瑞穗鄉"},
      {"zip": "979", "name": "萬榮鄉"},
      {"zip": "981", "name": "玉里鎮"},
      {"zip": "982", "name": "卓溪鄉"},
      {"zip": "983", "name": "富里鄉"}
    ],
    "name": "花蓮縣"
  }
];
