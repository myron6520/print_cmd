import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gbk_codec/gbk_codec.dart';

///TSPL
class LabelCommand {
  final List<int> _command = [];
  Uint8List get command => Uint8List.fromList(_command);
  void addStr(String str) {
    try {
      var encoded = gbk_bytes.encode(str);
      _command.addAll(encoded);
    } catch (e) {
      debugPrint("LabelCommand addStr error:$e");
    }
  }

  ///设定卷标纸的宽度和长度: SIZE 60 mm,40 mm
  void addSize(int width, int height) {
    String str = "SIZE $width mm,$height mm\r\n";
    addStr(str);
  }

  ///该指令用于定义两张卷标纸间的垂直间距距离: GAP 2 mm
  void addGap(int gap) => addStr("GAP $gap mm\r\n");
  void addPrint({int number = 1}) => addStr("PRINT $number\r\n");

  ///该指令用于清除图像缓冲区（image buffer)的数据。 注：此项指令必须置于SIZE指令之后
  void addCls() => addStr("CLS\r\n");
  void addDirection(int m) => addStr("DIRECTION $m\r\n");
  void addReference(int x, int y) => addStr("REFERENCE $x,$y\r\n");
  void addTear(bool enable) => addStr("SET TEAR ${enable ? 1 : 0}\r\n");
  void addCutter(bool enable) => addStr("SET CUTTER ${enable ? 1 : 0}\r\n");

  ///该指令用于打印字符串。TEXT x,y,"font",rotation,x-multiplication,y-multiplication,"content"
  /*
font	字体名称
1	8×12 dot 英数字体
2	12×20 dot 英数字体
3	16×24 dot 英数字体
4	24×32 dot 英数字体
5	32×48 dot 英数字体
6	14×19 dot 英数字体 OCR-B
7	21×27 dot 英数字体 OCR-B
8	14×25 dot 英数字体 OCR-A
9	9×17 dot 英数字体
10	12×24 dot 英数字体
TST24.BF2	繁体中文 24×24Font(大五码）
TSS24.BF2	简体中文 24×24Font（GB 码）
K	韩文 24×24Font（KS 码） */
/*
rotation	文字旋转角度（顺时针方向）
0	0 度
90	90 度
180	180 度
270	270 度 */

  void addText(String text, int x, int y, {int scale = 1, int rotation = 0, String font = "TSS24.BF2"}) => addStr(
        'TEXT $x,$y,"$font",$rotation,$scale,$scale,"$text"\r\n',
      );

  void addBarcode(
    String content,
    int x,
    int y,
    int height,
    bool readable, {
    int rotation = 0,
  }) =>
      addStr('BARCODE $x,$y,"128",$height,${readable ? 1 : 0},$rotation,2,4,"$content"\r\n');
}
