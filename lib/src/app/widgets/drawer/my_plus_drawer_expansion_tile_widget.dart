import 'package:brandstores/src/app/widgets/drawer/my_plus_drawer_list_item_widget.dart';
import 'package:flutter/material.dart';

class MyPlusDrawerExpansionTile extends ExpansionTile {
  const MyPlusDrawerExpansionTile({
    Key? key, 
    required Widget title, 
    bool initiallyExpanded = false, 
    EdgeInsetsGeometry? childrenPadding,
    this.onTap,
    required this.lastItem,
    void Function(bool)? onExpansionChanged,
    List<Widget> children = const <Widget>[],
    }) : super(
      key: key, 
      title: title, 
      initiallyExpanded: initiallyExpanded, 
      childrenPadding: childrenPadding,
      onExpansionChanged: onExpansionChanged,
      children: children);
  final void Function()? onTap;
  final bool lastItem;
  @override
  State<MyPlusDrawerExpansionTile> createState() => _MyPlusDrawerExpansionTileState();
} 
class _MyPlusDrawerExpansionTileState extends State<MyPlusDrawerExpansionTile> with SingleTickerProviderStateMixin {
  
  static final Animatable<double> _easeOutTween = CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);
  
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _headerColor;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _heightFactor = _controller.drive(_easeInTween);
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor = _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool? ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }
  Widget? _buildIcon(BuildContext context) {
    return RotationTransition(
      turns: _iconTurns,
      child: GestureDetector(
        onTap: _handleTap,
        child: const Icon(Icons.expand_more),
      ),
    );
  }

  Widget? _buildTrailingIcon(BuildContext context) {
    // if (_effectiveAffinity(widget.controlAffinity) != ListTileControlAffinity.trailing)
    //   return null;
    return _buildIcon(context);
  }
  Widget _buildChildren(BuildContext context, Widget? child) {
    // final Color borderSideColor = _borderColor.value ?? Colors.transparent;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTileTheme.merge(
          iconColor: _iconColor.value,
          textColor: _headerColor.value,
          child: MyPlusDrawerListItem(
            onTap: widget.onTap,
            // contentPadding: widget.tilePadding,
            // leading: widget.leading ?? _buildLeadingIcon(context),
            expanded: _isExpanded,
            title: widget.title,
            // subtitle: widget.subtitle,
            trailing: _buildTrailingIcon(context),
            lastItem: widget.lastItem,
          ),
        ),
        // const Divider(),
        ClipRect(
          child: Align(
            alignment: widget.expandedAlignment ?? Alignment.center,
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
      ],
    );
  }
  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    _headerColorTween
      ..begin = widget.collapsedTextColor ?? theme.textTheme.subtitle1!.color
      ..end = widget.textColor ?? colorScheme.primary;
    _iconColorTween
      ..begin = widget.collapsedIconColor ?? theme.unselectedWidgetColor
      ..end = widget.iconColor ?? colorScheme.primary;
    _backgroundColorTween
      ..begin = widget.collapsedBackgroundColor
      ..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: widget.childrenPadding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: widget.expandedCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }

}