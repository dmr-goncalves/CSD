<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_7" />
        <signal name="XLXN_8" />
        <signal name="XLXN_9" />
        <signal name="RESET" />
        <signal name="PLUS" />
        <signal name="NEXTDIGIT" />
        <signal name="XLXN_13(3:0)" />
        <signal name="XLXN_14(3:0)" />
        <signal name="XLXN_15(3:0)" />
        <signal name="XLXN_16(3:0)" />
        <signal name="XLXN_24" />
        <signal name="CLK" />
        <signal name="COLOR" />
        <signal name="ZOOM(1:0)" />
        <signal name="RED" />
        <signal name="GRN" />
        <signal name="BLU" />
        <signal name="VS" />
        <signal name="HS" />
        <signal name="XLXN_36" />
        <port polarity="Input" name="RESET" />
        <port polarity="Input" name="PLUS" />
        <port polarity="Input" name="NEXTDIGIT" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="COLOR" />
        <port polarity="Input" name="ZOOM(1:0)" />
        <port polarity="Output" name="RED" />
        <port polarity="Output" name="GRN" />
        <port polarity="Output" name="BLU" />
        <port polarity="Output" name="VS" />
        <port polarity="Output" name="HS" />
        <blockdef name="DATA">
            <timestamp>2015-10-25T14:52:1</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="VGA">
            <timestamp>2015-10-25T14:52:7</timestamp>
            <rect width="256" x="64" y="-448" height="448" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-416" y2="-416" x1="320" />
            <line x2="384" y1="-320" y2="-320" x1="320" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-128" y2="-128" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="CONTROL">
            <timestamp>2015-10-25T15:4:4</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-128" y2="-128" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="DATA" name="XLXI_2">
            <blockpin signalname="XLXN_7" name="ZERO" />
            <blockpin signalname="XLXN_8" name="SUM" />
            <blockpin signalname="XLXN_9" name="NEXT_DIGIT" />
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="XLXN_13(3:0)" name="ALG1(3:0)" />
            <blockpin signalname="XLXN_14(3:0)" name="ALG2(3:0)" />
            <blockpin signalname="XLXN_15(3:0)" name="ALG3(3:0)" />
            <blockpin signalname="XLXN_16(3:0)" name="ALG4(3:0)" />
        </block>
        <block symbolname="CONTROL" name="XLXI_5">
            <blockpin signalname="RESET" name="RESET" />
            <blockpin signalname="PLUS" name="PLUS" />
            <blockpin signalname="NEXTDIGIT" name="NEXTDIGIT" />
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="XLXN_7" name="ZERO" />
            <blockpin signalname="XLXN_8" name="SUM" />
            <blockpin signalname="XLXN_9" name="NEXT_DIGIT" />
        </block>
        <block symbolname="VGA" name="XLXI_4">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="COLOR" name="COLOR" />
            <blockpin signalname="XLXN_13(3:0)" name="ALG1(3:0)" />
            <blockpin signalname="XLXN_14(3:0)" name="ALG2(3:0)" />
            <blockpin signalname="XLXN_15(3:0)" name="ALG3(3:0)" />
            <blockpin signalname="XLXN_16(3:0)" name="ALG4(3:0)" />
            <blockpin signalname="ZOOM(1:0)" name="ZOOM(1:0)" />
            <blockpin signalname="RED" name="RED" />
            <blockpin signalname="GRN" name="GRN" />
            <blockpin signalname="BLU" name="BLU" />
            <blockpin signalname="HS" name="HS" />
            <blockpin signalname="VS" name="VS" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="336" y="800" name="XLXI_5" orien="R0">
        </instance>
        <branch name="XLXN_7">
            <wire x2="816" y1="576" y2="576" x1="720" />
        </branch>
        <branch name="RESET">
            <wire x2="336" y1="576" y2="576" x1="304" />
        </branch>
        <iomarker fontsize="28" x="304" y="576" name="RESET" orien="R180" />
        <branch name="PLUS">
            <wire x2="336" y1="640" y2="640" x1="304" />
        </branch>
        <iomarker fontsize="28" x="304" y="640" name="PLUS" orien="R180" />
        <branch name="NEXTDIGIT">
            <wire x2="336" y1="704" y2="704" x1="304" />
        </branch>
        <iomarker fontsize="28" x="304" y="704" name="NEXTDIGIT" orien="R180" />
        <branch name="XLXN_13(3:0)">
            <wire x2="1216" y1="576" y2="576" x1="1200" />
            <wire x2="1488" y1="576" y2="576" x1="1216" />
        </branch>
        <branch name="XLXN_14(3:0)">
            <wire x2="1216" y1="640" y2="640" x1="1200" />
            <wire x2="1488" y1="640" y2="640" x1="1216" />
        </branch>
        <branch name="XLXN_15(3:0)">
            <wire x2="1216" y1="704" y2="704" x1="1200" />
            <wire x2="1488" y1="704" y2="704" x1="1216" />
        </branch>
        <branch name="XLXN_16(3:0)">
            <wire x2="1216" y1="768" y2="768" x1="1200" />
            <wire x2="1488" y1="768" y2="768" x1="1216" />
        </branch>
        <branch name="CLK">
            <wire x2="256" y1="768" y2="768" x1="240" />
            <wire x2="336" y1="768" y2="768" x1="256" />
            <wire x2="256" y1="768" y2="880" x1="256" />
            <wire x2="800" y1="880" y2="880" x1="256" />
            <wire x2="1488" y1="448" y2="448" x1="800" />
            <wire x2="800" y1="448" y2="768" x1="800" />
            <wire x2="800" y1="768" y2="880" x1="800" />
            <wire x2="816" y1="768" y2="768" x1="800" />
        </branch>
        <iomarker fontsize="28" x="240" y="768" name="CLK" orien="R180" />
        <instance x="816" y="800" name="XLXI_2" orien="R0">
        </instance>
        <branch name="XLXN_8">
            <wire x2="736" y1="672" y2="672" x1="720" />
            <wire x2="816" y1="640" y2="640" x1="736" />
            <wire x2="736" y1="640" y2="672" x1="736" />
        </branch>
        <branch name="XLXN_9">
            <wire x2="736" y1="768" y2="768" x1="720" />
            <wire x2="816" y1="704" y2="704" x1="736" />
            <wire x2="736" y1="704" y2="768" x1="736" />
        </branch>
        <instance x="1488" y="864" name="XLXI_4" orien="R0">
        </instance>
        <branch name="COLOR">
            <wire x2="1472" y1="512" y2="512" x1="1456" />
            <wire x2="1488" y1="512" y2="512" x1="1472" />
        </branch>
        <branch name="ZOOM(1:0)">
            <wire x2="1472" y1="832" y2="832" x1="1456" />
            <wire x2="1488" y1="832" y2="832" x1="1472" />
        </branch>
        <branch name="RED">
            <wire x2="1888" y1="448" y2="448" x1="1872" />
            <wire x2="1904" y1="448" y2="448" x1="1888" />
        </branch>
        <branch name="GRN">
            <wire x2="1888" y1="544" y2="544" x1="1872" />
            <wire x2="1904" y1="544" y2="544" x1="1888" />
        </branch>
        <branch name="BLU">
            <wire x2="1888" y1="640" y2="640" x1="1872" />
            <wire x2="1904" y1="640" y2="640" x1="1888" />
        </branch>
        <branch name="VS">
            <wire x2="1888" y1="832" y2="832" x1="1872" />
            <wire x2="1904" y1="832" y2="832" x1="1888" />
        </branch>
        <branch name="HS">
            <wire x2="1888" y1="736" y2="736" x1="1872" />
            <wire x2="1904" y1="736" y2="736" x1="1888" />
        </branch>
        <iomarker fontsize="28" x="1456" y="512" name="COLOR" orien="R180" />
        <iomarker fontsize="28" x="1456" y="832" name="ZOOM(1:0)" orien="R180" />
        <iomarker fontsize="28" x="1904" y="448" name="RED" orien="R0" />
        <iomarker fontsize="28" x="1904" y="544" name="GRN" orien="R0" />
        <iomarker fontsize="28" x="1904" y="640" name="BLU" orien="R0" />
        <iomarker fontsize="28" x="1904" y="832" name="VS" orien="R0" />
        <iomarker fontsize="28" x="1904" y="736" name="HS" orien="R0" />
    </sheet>
</drawing>