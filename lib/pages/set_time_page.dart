import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mediation_app/utils/strings.dart';
import 'package:mediation_app/utils/theme.dart';
import 'package:mediation_app/widgets/meditation_button.dart';
import 'package:mediation_app/widgets/responsive_builder.dart';

class SetTimePage extends StatelessWidget {
  SetTimePage({super.key});

  final List<String> dayOfWeek = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ResponsiveBuilder(
            landscape: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: _TimeHeader(
                          SetTimePageStrings.pickTimeTitle,
                          SetTimePageStrings.pickTimeSubtitle,
                        ),
                      ),
                      Flexible(flex: 2, child: _TimePicker()),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: _TimeHeader(
                          SetTimePageStrings.pickDayTitle,
                          SetTimePageStrings.pickDaySubtitle,
                        ),
                      ),
                      Expanded(
                        child: _DayPicker(
                          dayOfWeek: dayOfWeek,
                          onDaySelected: (index) {},
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            MeditationButton(
                              onClick: () {},
                              textStyle: PrimaryFont.medium(
                                14,
                              ).copyWith(color: Colors.white),
                              backgroundColor: kColorPrimary,
                              buttontext: SetTimePageStrings.everyDay,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  SetTimePageStrings.noThanks,
                                  style: PrimaryFont.medium(14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            portrait: Column(
              children: [
                Spacer(),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: _TimeHeader(
                    SetTimePageStrings.pickTimeTitle,
                    SetTimePageStrings.pickTimeSubtitle,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: _TimePicker(),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: _TimeHeader(
                    SetTimePageStrings.pickDayTitle,
                    SetTimePageStrings.pickDaySubtitle,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: _DayPicker(
                    dayOfWeek: dayOfWeek,
                    onDaySelected: (index) {},
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Column(
                    children: [
                      MeditationButton(
                        onClick: () {},
                        textStyle: PrimaryFont.medium(
                          14,
                        ).copyWith(color: Colors.white),
                        backgroundColor: kColorPrimary,
                        buttontext: SetTimePageStrings.everyDay,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            SetTimePageStrings.noThanks,
                            style: PrimaryFont.medium(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DayPicker extends StatefulWidget {
  const _DayPicker({required this.dayOfWeek, required this.onDaySelected});

  final List<String> dayOfWeek;
  final Function(int index) onDaySelected;

  @override
  State<_DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<_DayPicker> {
  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: InkWell(
              onTap: () {
                widget.onDaySelected(index);
                setState(() {
                  selectedIndex = index;
                });
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      selectedIndex == index
                          ? kColorDarkGrey
                          : Colors.transparent,
                  border:
                      selectedIndex == index
                          ? null
                          : Border.all(color: kColorMediumGrey, width: 2.0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.dayOfWeek[index],
                    style: PrimaryFont.medium(16).copyWith(
                      color:
                          selectedIndex == index
                              ? Colors.white
                              : kColorDarkGrey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TimePicker extends StatelessWidget {
  const _TimePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          SizedBox.expand(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return ui.Gradient.linear(
                  const Offset(0, 0),
                  Offset(0, bounds.height),
                  [
                    const Color(0x26F5F5F9),
                    const Color.fromARGB(111, 245, 245, 249),
                    const Color(0xFFF5F5F9),
                    const Color(0xFFF5F5F9),
                    const Color.fromARGB(111, 245, 245, 249),
                    const Color(0x26F5F5F9),
                  ],
                  [0, 0.2, 0.3, 0.7, 0.8, 1],
                );
              },
            ),
          ),
          Row(
            children: [
              Spacer(),
              Expanded(
                child: _TimeWheel((index) => '${index % 12 + 1}', (item) {}),
              ),
              Expanded(
                child: _TimeWheel((index) => '${index % 60 + 1}', (item) {}),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListWheelScrollView(
                      overAndUnderCenterOpacity: 0.5,
                      itemExtent: constraints.maxHeight * 0.2,
                      children: [
                        FittedBox(
                          child: Text('AM', style: PrimaryFont.bold(24)),
                        ),
                        FittedBox(
                          child: Text('PM', style: PrimaryFont.bold(24)),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Spacer(),
            ],
          ),
          const Align(
            alignment: Alignment(0, -0.3),
            child: Divider(color: Color(0xFFE1E1E5)),
          ),
          const Align(
            alignment: Alignment(0, 0.2),
            child: Divider(color: Color(0xFFE1E1E5)),
          ),
        ],
      ),
    );
  }
}

class _TimeWheel extends StatefulWidget {
  _TimeWheel(this.itemText, this.onSelectedItemChanged);

  final String Function(int index) itemText;
  final Function(String item) onSelectedItemChanged;
  final FixedExtentScrollController _controller = FixedExtentScrollController();

  @override
  State<_TimeWheel> createState() => _TimeWheelState();
}

class _TimeWheelState extends State<_TimeWheel> {
  int _currentIndex = 0;

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      if (event.scrollDelta.dy > 0) {
        setState(() {
          _currentIndex++;
        });
      } else if (event.scrollDelta.dy < 0) {
        setState(() {
          _currentIndex--;
        });
      }

      widget._controller.animateToItem(
        _currentIndex,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Listener(
          onPointerSignal: _handlePointerSignal,
          child: ListWheelScrollView.useDelegate(
            controller: widget._controller,
            itemExtent: constraints.maxHeight * 0.2,
            squeeze: 0.8,
            diameterRatio: 1.4,
            physics: const NeverScrollableScrollPhysics(),
            overAndUnderCenterOpacity: 0.5,
            onSelectedItemChanged: (index) {
              widget.onSelectedItemChanged(widget.itemText(index));
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return FittedBox(
                  child: Text(
                    widget.itemText(index),
                    style: PrimaryFont.bold(24),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _TimeHeader extends StatelessWidget {
  const _TimeHeader(this.title, this.subtitle);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: PrimaryFont.bold(
              24,
            ).copyWith(color: kColorDarkGrey, height: 1.35),
          ),
        ),
        Expanded(
          child: Text(
            subtitle,
            style: PrimaryFont.light(16).copyWith(color: kColorMediumGrey),
          ),
        ),
      ],
    );
  }
}
