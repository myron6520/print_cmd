import 'dart:typed_data';

import 'package:print_cmd/tsc/label_command.dart';

class LabelHelper {
  static Uint8List build4030Tspl({
    required String no,
    required String name,
    required String specification,
    required String date,
    String separator = "-",
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("CLS \r\n");
    cmd.addSize(40, 30);
    cmd.addText("#${no}", offsetX, offsetY, font: "TSS24.BF2", scale: 2);
    cmd.addText(separator * 24, offsetX, offsetY + 50);
    cmd.addText(name, offsetX, offsetY + 80, font: "TSS24.BF2", scale: 2);
    cmd.addText(specification, offsetX, offsetY + 140, font: "TSS24.BF2");
    cmd.addText(separator * 24, offsetX, offsetY + 170);
    cmd.addText(date, offsetX, offsetY + 190, font: "TSS24.BF2");
    cmd.addPrint();
    return cmd.command;
  }

  static Uint8List build6040Tspl({
    required String no,
    required String name,
    required String specification,
    required String date,
    String separator = "-",
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("CLS \r\n");
    cmd.addSize(60, 40);
    cmd.addText("#${no}", offsetX, offsetY, font: "TSS24.BF2", scale: 2);
    cmd.addText(separator * 36, offsetX, offsetY + 50);
    cmd.addText(name, offsetX, offsetY + 80, font: "TSS24.BF2", scale: 2);
    if (specification.length > 18) {
      cmd.addText(specification.substring(0, 18), offsetX, offsetY + 140,
          font: "TSS24.BF2");
      cmd.addText(specification.substring(18), offsetX, offsetY + 170,
          font: "TSS24.BF2");
    } else {
      cmd.addText(specification, offsetX, offsetY + 140, font: "TSS24.BF2");
    }
    cmd.addText(separator * 36, offsetX, offsetY + 230);
    cmd.addText(date, offsetX, offsetY + 250, font: "TSS24.BF2");
    cmd.addPrint();
    return cmd.command;
  }

  static Uint8List build4030Cpcl({
    required String no,
    required String name,
    required String specification,
    required String date,
    String separator = "-",
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("! 0 200 200 200 1\r\n");
    cmd.addStr("PW 400\r\n");
    cmd.addStr("TONE 0\r\n");
    cmd.addStr("SPEED 4\r\n");
    cmd.addStr("SETBOLD 1\r\n");
    cmd.addStr("LEFT\r\n");
    cmd.addStr('TEXT 4 1 $offsetX ${offsetY + 0} #$no\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 60} ${separator * 18}\r\n');
    cmd.addStr("SETBOLD 1\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 90} $name\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 2 1 $offsetX ${offsetY + 130} $specification\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 155} ${separator * 18}\r\n');
    cmd.addStr('TEXT 5 0 $offsetX ${offsetY + 175} $date\r\n');
    cmd.addStr("FORM\r\n");
    cmd.addStr("PRINT\r\n");
    return cmd.command;
  }

  static Uint8List build6040Cpcl({
    required String no,
    required String name,
    required String specification,
    required String date,
    String separator = "-",
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("! 0 200 200 300 1\r\n");
    cmd.addStr("PW 400\r\n");
    cmd.addStr("TONE 0\r\n");
    cmd.addStr("SPEED 4\r\n");
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr("LEFT\r\n");
    cmd.addStr('TEXT 4 1 $offsetX ${offsetY + 0} #$no\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 60} ${separator * 32}\r\n');
    cmd.addStr("SETBOLD 1\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 90} $name\r\n');
    cmd.addStr("SETBOLD 0\r\n");
    if (specification.length > 16) {
      cmd.addStr(
          'TEXT 2 1 $offsetX ${offsetY + 140} ${specification.substring(0, 16)}\r\n');
      cmd.addStr(
          'TEXT 2 1 $offsetX ${offsetY + 170} ${specification.substring(16)}\r\n');
    } else {
      cmd.addStr('TEXT 2 1 $offsetX ${offsetY + 140} $specification\r\n');
    }

    cmd.addStr("SETBOLD 0\r\n");
    cmd.addStr('TEXT 4 0 $offsetX ${offsetY + 230} ${separator * 32}\r\n');
    cmd.addStr('TEXT 2 1 $offsetX ${offsetY + 250} $date\r\n');
    cmd.addStr("FORM\r\n");
    cmd.addStr("PRINT\r\n");
    return cmd.command;
  }

  static Uint8List build4030TsplRetail({
    required String shopName,
    required String name,
    required String barcode,
    required String spec,
    required String sellPrice,
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("CLS \r\n");
    cmd.addSize(40, 30);
    cmd.addText(shopName, offsetX + 10, offsetY + 10,
        font: "TSS24.BF2", scale: shopName.length > 6 ? 1 : 2);
    cmd.addText('品名：$name', offsetX + 10, offsetY + 60, font: "TSS24.BF2");
    cmd.addText('规格：$spec', offsetX + 10, offsetY + 90, font: "TSS24.BF2");
    cmd.addText('销售价：$sellPrice元', offsetX + 10, offsetY + 120,
        font: "TSS24.BF2");
    // cmd.addText('条形码：', offsetX + 10, offsetY + 165, font: "TSS24.BF2");
    cmd.addBarcode(barcode, 10 + offsetX, 150 + offsetY, 56, false);
    cmd.addPrint();
    return cmd.command;
  }

  static Uint8List build4030CpclRetail({
    required String shopName,
    required String name,
    required String barcode,
    required String spec,
    required String sellPrice,
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("! 0 200 200 200 1\r\n");
    cmd.addStr("PW 400\r\n");
    cmd.addStr("TONE 0\r\n");
    cmd.addStr("SPEED 4\r\n");
    cmd.addStr("LEFT\r\n");
    cmd.addStr("SETBOLD 1 \r\n");
    cmd.addStr('TEXT 4 0 ${offsetX + 10} ${offsetY + 10} $shopName\r\n');
    cmd.addStr("SETBOLD 1 \r\n");
    cmd.addStr('TEXT 2 1 ${offsetX + 10} ${offsetY + 50} 品名：$name\r\n');
    cmd.addStr("SETBOLD 1 \r\n");
    cmd.addStr('TEXT 2 1 ${offsetX + 10} ${offsetY + 85} 规格：$spec\r\n');
    cmd.addStr("SETBOLD 1 \r\n");
    cmd.addStr('TEXT 2 1 ${offsetX + 10} ${offsetY + 120} 销售价：$sellPrice元\r\n');
    cmd.addStr("SETBOLD 1 \r\n");
    // cmd.addStr('TEXT 2 1 ${offsetX + 10} ${offsetY + 165} 条形码：\r\n');
    cmd.addStr('BARCODE-W 1\r\n');
    cmd.addStr(
        "BARCODE 128 1 0 50 ${10 + offsetX} ${155 + offsetY} $barcode\r\n");
    cmd.addStr("FORM\r\n");
    cmd.addStr("PRINT\r\n");
    return cmd.command;
  }

  static int getCharLen(String char) {
    int len = 0;
    // 定义中文字符和中文标点符号的正则表达式
    String chineseAndPunctuationRegex =
        r"[\u4E00-\u9FFF\u3000-\u303F\uFF00-\uFFEF]";
    RegExp regExp = RegExp(chineseAndPunctuationRegex);
    if (regExp.hasMatch(char)) {
      return 2; // 中文字符和标点符号占 2 个长度
    } else {
      return 1; // 英文字符、数字等占 1 个长度
    }
  }

  static List<(int, String)> getPrintLines({
    required String text,
    required int maxLen,
  }) {
    List<(int, String)> lines = [];
    String line = "";
    int len = 0;
    for (int i = 0; i < text.length; i++) {
      String char = text.substring(i, i + 1);
      int charLen = getCharLen(char);
      if (len + charLen <= maxLen) {
        len += charLen;
        line = "$line$char";
      } else {
        lines.add((len, line));
        line = "$char";
        len = charLen;
      }
    }
    if (line.isNotEmpty) {
      lines.add((len, line));
    }
    return lines;
  }

  static Uint8List build60100CpclRetail({
    required String name,
    required String barcode,
    required String spec,
    required String sellPrice,
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("! 0 200 420 700 1\r\n");
    cmd.addStr("PW 600\r\n");
    cmd.addStr("TONE 0\r\n");
    cmd.addStr("SPEED 4\r\n");
    cmd.addStr("LEFT\r\n");
    cmd.addStr("SETBOLD 1 \r\n");
    cmd.addStr("SETMAG 2 2 \r\n");
    int y = 10;
    {
      final lines = getPrintLines(text: name, maxLen: 12);
      for (var e in lines) {
        int x = (420 - e.$1 * 30) ~/ 2;
        cmd.addStr('TEXT 4 0 ${offsetX + 10 + x} ${offsetY + y} ${e.$2}\r\n');
        y += 64;
      }
    }
    y += 16;
    {
      cmd.addStr("SETBOLD 0 \r\n");
      final lines = getPrintLines(text: spec, maxLen: 28);
      for (var e in lines) {
        int x = (420 - e.$1 * 15) ~/ 2;
        cmd.addStr('TEXT 2 1 ${offsetX + 10 + x} ${offsetY + y} ${e.$2}\r\n');
        y += 64;
      }
    }
    y += 16;
    {
      cmd.addStr("SETBOLD 0 \r\n");

      final lines = getPrintLines(text: "销售价：$sellPrice元", maxLen: 28);
      for (var e in lines) {
        int x = (420 - e.$1 * 15) ~/ 2;
        cmd.addStr('TEXT 2 1 ${offsetX + 10 + x} ${offsetY + y} ${e.$2}\r\n');
        y += 64;
      }
    }
    {
      cmd.addStr('BARCODE-W 1\r\n');

      ///Code 128 总条数 = 开始符(11) + (每字符11 * N) + 校验码(11) + 结束符(13)
      int barLineCnt = 11 + (11 * barcode.length) + 11 + 13;
      cmd.addStr(
          "BARCODE 128 1 0 100 ${10 + offsetX + (420 - barLineCnt) ~/ 2} ${600 + offsetY} $barcode\r\n");
    }
    cmd.addStr("FORM\r\n");
    cmd.addStr("PRINT\r\n");
    return cmd.command;
  }

  static Uint8List build60100TsplRetail({
    required String name,
    required String barcode,
    required String spec,
    required String sellPrice,
    int offsetX = 0,
    int offsetY = 0,
  }) {
    LabelCommand cmd = LabelCommand();
    cmd.addStr("CLS \r\n");
    cmd.addSize(60, 90);
    int y = 10;
    {
      final lines = getPrintLines(text: name, maxLen: 20);
      for (var e in lines) {
        int x = (480 - e.$1 * 24) ~/ 2;
        cmd.addText(e.$2, offsetX + x, offsetY + y,
            font: "TSS24.BF2", scale: 2);
        y += 48;
      }
    }
    y += 24;
    {
      final lines = getPrintLines(text: spec, maxLen: 40);
      for (var e in lines) {
        int x = (480 - e.$1 * 12) ~/ 2;
        cmd.addText(e.$2, offsetX + x, offsetY + y, font: "TSS24.BF2");
        y += 24;
      }
    }
    y += 24;
    {
      final lines = getPrintLines(text: "销售价：$sellPrice元", maxLen: 20);
      for (var e in lines) {
        int x = (480 - e.$1 * 24) ~/ 2;
        cmd.addText(e.$2, offsetX + x, offsetY + y,
            font: "TSS24.BF2", scale: 2);
        y += 48;
      }
    }
    int barcode_width = barcode.length * 11 * 2;
    cmd.addStr(
        'BARCODE ${10 + offsetX + (480 - barcode_width) ~/ 2},${560 + offsetY},"128",100,1,0,2,2,"$barcode"\r\n');
    cmd.addPrint();
    return cmd.command;
  }
}
