#! /usr/bin/env perl
use strict;
use warnings;

my @dice_com;
my @dice_you;
my $point_com = 3;
my $point_you = 3;

# my $dice_total_com = 0;
# my $dice_total_you = 0;

print "チンチロリンゲーム！\n";
print "サイコロを3回振ります。\n";
print "お互いに3点ずつ掛け合います。\n\n";

print "コンピューターのターンです。\n";
&com_turn( 1, 5, 5 );

print "あなたのターンです。\n";
&your_turn();

if ( $point_you > $point_com || 0 > $point_com ) {
    print "あなたの勝ちです！\n";
}
elsif ( $point_com > $point_you ) {

    #lose
    print "おや？サイコロが跳ね返って…？\n";
    if ( $point_com >= $point_you ) {
        &cheat_you();
        print &cheat_you() . "\n";
    }
    if ( cheat_you() > cheat_comp() ) {
        print "あなたの勝ちです！\n";
    }
}
else {
    #drow
    print "突風が吹いた！\n";
    if ( $point_com == $point_you ) {
        &cheat_you();
        print &cheat_you() . "\n";
    }
    if ( &cheat_you() > &cheat_comp() ) {
        print "あなたの勝ちです！\n";
    }
}

sub com_turn {
    for ( my $i = 1; $i < 4; $i++ ) {
        my $dice_roll_com = int( rand(6) ) + 1;

        push( @dice_com, $dice_roll_com );
    }

    if (@_) {

 # この関数に引数がある場合、その値を出た目とする
 # @_ はサブルーチンに渡された引数が格納されている配列
        @dice_com = @_;
    }

    print "1回目のサイコロの眼:" . $dice_com[0] . "\n";
    print "2回目のサイコロの眼:" . $dice_com[1] . "\n";
    print "3回目のサイコロの眼:" . $dice_com[2] . "\n";

    # $dice_total_com = $dice_com[0] + $dice_com[1] + $dice_com[2];

    # サイコロの目をハッシュに格納する
    # サイコロの目をkeyに、その目が出た回数をvalueに設定
    my %dice_com_hash = ();
    foreach my $n (@dice_com) {
        $dice_com_hash{$n}++;
    }

    # ゾロ目の時の判定
    # %dice_com_hash の key が1つしか無い場合、ゾロ目が
    # 出たと判断
    if ( ( keys %dice_com_hash ) == 1 )

    {
        # %dice_com_hash に 1 という key がある場合
        # ピンゾロ

        if ( exists $dice_com_hash{1} ) {

            #               負けちゃうのでチートする
            print "★★★ピンゾロCOMチート★★★\n";
        }

        # %dice_com_hash のkey が 1 以外の場合
        # アラシ
        else {
            #               負けちゃうのでチートする
            print "★★★アラシCOMチート★★★\n";
        }
        return &cheat_comp();

    }

    # インケツ(1,?,?)
    elsif (( keys %dice_com_hash ) == 2 && $dice_com_hash{1} == 1)
    # (( ( $dice_com[0] == $dice_com[1] ) && $dice_com[2] == 1 )
    #     || ( ( $dice_com[1] == $dice_com[2] ) && $dice_com[0] == 1 )
    #     || ( ( $dice_com[2] == $dice_com[0] ) && $dice_com[1] == 1 ) )
    {
        $point_com = 1;
        print "インケツ。" . $point_com . "点。\n\n";
    }



    # ニタコ(2,?,?)
    elsif (( ( $dice_com[0] == $dice_com[1] ) && $dice_com[2] == 2 )
        || ( ( $dice_com[1] == $dice_com[2] ) && $dice_com[0] == 2 )
        || ( ( $dice_com[2] == $dice_com[0] ) && $dice_com[1] == 2 ) )
    {
        $point_com = 2;
        print "ニタコ。" . $point_com . "点。\n\n";

    }

    # サンタ(3,?,?)
    elsif (( ( $dice_com[0] == $dice_com[1] ) && $dice_com[2] == 3 )
        || ( ( $dice_com[1] == $dice_com[2] ) && $dice_com[0] == 3 )
        || ( ( $dice_com[2] == $dice_com[0] ) && $dice_com[1] == 3 ) )
    {
        $point_com = 3;
        print "サンタ。" . $point_com . "点。\n\n";

    }

    # シニメ(4,?,?)
    elsif (( ( $dice_com[0] == $dice_com[1] ) && $dice_com[2] == 4 )
        || ( ( $dice_com[1] == $dice_com[2] ) && $dice_com[0] == 4 )
        || ( ( $dice_com[2] == $dice_com[0] ) && $dice_com[1] == 4 ) )
    {
        $point_com = 4;
        print "シニメ。" . $point_com . "点。\n\n";

    }

    # ゴケ(5,?,?)
    elsif (( ( $dice_com[0] == $dice_com[1] ) && $dice_com[2] == 5 )
        || ( ( $dice_com[1] == $dice_com[2] ) && $dice_com[0] == 5 )
        || ( ( $dice_com[2] == $dice_com[0] ) && $dice_com[1] == 5 ) )
    {

        #               負けちゃうのでチートする
        return &cheat_comp();
        print "★★★ゴケCOMチート★★★\n";

    }

    # ロッポウ(6,?,?)
    elsif (( ( $dice_com[0] == $dice_com[1] ) && $dice_com[2] == 6 )
        || ( ( $dice_com[1] == $dice_com[2] ) && $dice_com[0] == 6 )
        || ( ( $dice_com[2] == $dice_com[0] ) && $dice_com[1] == 6 ) )
    {

        #               負けちゃうのでチートする
        print "★★★ロッポウCOMチート★★★\n";
        return &cheat_comp();

    }

    # ヒフミ(1,2,3)
    elsif (( $dice_com[0] == 1 && $dice_com[1] == 2 && $dice_com[2] == 3 )
        || ( $dice_com[0] == 3 && $dice_com[1] == 1 && $dice_com[2] == 2 )
        || ( $dice_com[0] == 2 && $dice_com[1] == 3 && $dice_com[2] == 1 ) )
    {
        $point_com = 3;
        $point_com *= -2;
        print "ヒフミ。2倍負け。" . $point_com . "点。\n\n";

    }
    elsif (( $dice_com[0] == 4 && $dice_com[1] == 5 && $dice_com[2] == 6 )
        || ( $dice_com[0] == 6 && $dice_com[1] == 4 && $dice_com[2] == 5 )
        || ( $dice_com[0] == 5 && $dice_com[1] == 6 && $dice_com[2] == 4 ) )
    {

        #               負けちゃうのでチートする
        print "★★★ヒフミCOMチート★★★\n";
        return &cheat_comp();

    }

    # メナシ(上記パターンに無い場合)
    else {
        $point_com = 0;
        print "メナシ。" . $point_com . "点。\n\n";
    }

    #array clear
    for ( my $k = 1; $k < 4; $k++ ) {
        shift(@dice_com);
    }
    return $point_com;
}

sub your_turn {
    print "何かキーを押してください。";
    <STDIN>;

    for ( my $i = 1; $i < 4; $i++ ) {
        my $dice_roll_you = int( rand(6) ) + 1;

        push( @dice_you, $dice_roll_you );
    }

    print "1回目のサイコロの眼:" . $dice_you[0] . "\n";
    print "2回目のサイコロの眼:" . $dice_you[1] . "\n";
    print "3回目のサイコロの眼:" . $dice_you[2] . "\n";

    # $dice_total_you = $dice_you[0] + $dice_you[1] + $dice_you[2];

    if ((      ( $dice_you[0] == $dice_you[1] )
            && ( $dice_you[1] == $dice_you[2] )
            && ( $dice_you[2] == $dice_you[0] )
        )
        && $dice_you[0] == 1
        )
    {
        $point_you = 3;
        $point_you *= 5;
        print "ピンゾロのアラシ。5倍勝ち。"
            . $point_you
            . "点。\n\n";

    }
    elsif (( $dice_you[0] == $dice_you[1] )
        && ( $dice_you[1] == $dice_you[2] )
        && ( $dice_you[2] == $dice_you[0] ) )
    {
        $point_you = 3;
        $point_you *= 3;
        print "アラシ。3倍勝ち。" . $point_you . "点。\n\n";

    }
    elsif (( ( $dice_you[0] == $dice_you[1] ) && $dice_you[2] == 1 )
        || ( ( $dice_you[1] == $dice_you[2] ) && $dice_you[0] == 1 )
        || ( ( $dice_you[2] == $dice_you[0] ) && $dice_you[1] == 1 ) )
    {
        $point_you = 1;
        print "インケツ。" . $point_you . "点。\n\n";

    }
    elsif (( ( $dice_you[0] == $dice_you[1] ) && $dice_you[2] == 2 )
        || ( ( $dice_you[1] == $dice_you[2] ) && $dice_you[0] == 2 )
        || ( ( $dice_you[2] == $dice_you[0] ) && $dice_you[1] == 2 ) )
    {
        $point_you = 2;
        print "ニタコ。" . $point_you . "点。\n\n";

    }
    elsif (( ( $dice_you[0] == $dice_you[1] ) && $dice_you[2] == 3 )
        || ( ( $dice_you[1] == $dice_you[2] ) && $dice_you[0] == 3 )
        || ( ( $dice_you[2] == $dice_you[0] ) && $dice_you[1] == 3 ) )
    {
        $point_you = 3;
        print "サンタ。" . $point_you . "点。\n\n";

    }
    elsif (( ( $dice_you[0] == $dice_you[1] ) && $dice_you[2] == 4 )
        || ( ( $dice_you[1] == $dice_you[2] ) && $dice_you[0] == 4 )
        || ( ( $dice_you[2] == $dice_you[0] ) && $dice_you[1] == 4 ) )
    {
        $point_you = 4;
        print "シニメ。" . $point_you . "点。\n\n";

    }
    elsif (( ( $dice_you[0] == $dice_you[1] ) && $dice_you[2] == 5 )
        || ( ( $dice_you[1] == $dice_you[2] ) && $dice_you[0] == 5 )
        || ( ( $dice_you[2] == $dice_you[0] ) && $dice_you[1] == 5 ) )
    {
        $point_you = 5;
        print "ゴケ。" . $point_you . "点。\n\n";

    }
    elsif (( ( $dice_you[0] == $dice_you[1] ) && $dice_you[2] == 6 )
        || ( ( $dice_you[1] == $dice_you[2] ) && $dice_you[0] == 6 )
        || ( ( $dice_you[2] == $dice_you[0] ) && $dice_you[1] == 6 ) )
    {
        $point_you = 6;
        print "ロッポウ。" . $point_you . "点。\n\n";

    }
    elsif (( $dice_you[0] == 1 && $dice_you[1] == 2 && $dice_you[2] == 3 )
        || ( $dice_you[0] == 3 && $dice_you[1] == 1 && $dice_you[2] == 2 )
        || ( $dice_you[0] == 2 && $dice_you[1] == 3 && $dice_you[2] == 1 ) )
    {

        # ヒフミは負けるのでチート
        print "★★★ヒフミ自分チート★★★\n";
        return &cheat_you();

    }
    elsif (( $dice_you[0] == 4 && $dice_you[1] == 5 && $dice_you[2] == 6 )
        || ( $dice_you[0] == 6 && $dice_you[1] == 4 && $dice_you[2] == 5 )
        || ( $dice_you[0] == 5 && $dice_you[1] == 6 && $dice_you[2] == 4 ) )
    {
        $point_you = 3;
        $point_you *= 2;
        print "ジゴロ。2倍勝ち。" . $point_you . "点。\n\n";
    }
    else {
        # メナシは0点なのでチート
        print "★★★メナシ自分チート★★★\n";
        return &cheat_you();
    }

    #array clear
    for ( my $k = 1; $k < 4; $k++ ) {
        shift(@dice_you);
    }
    return $point_you;
}

sub cheat_comp {

    # チートするときはサンタで出す
    my @cheat_com;
    my $cheat_com_point;
    $cheat_com[0]    = 1;
    $cheat_com[1]    = 1;
    $cheat_com[2]    = 3;
    $cheat_com_point = 3;

    print "★★★COMチート★★★\n";

    print "おっと、サイコロが跳ね返った！\n\n";
    print "1回目のサイコロの眼:" . $cheat_com[0] . "\n";
    print "2回目のサイコロの眼:" . $cheat_com[1] . "\n";
    print "3回目のサイコロの眼:" . $cheat_com[2] . "\n";
    print "サンタ。" . $cheat_com_point . "点。\n\n";

    for ( my $k = 1; $k < 4; $k++ ) {
        shift(@cheat_com);
    }

    return $cheat_com_point;
}

sub cheat_you {

    #               チートするときはゴケで出す
    my @cheat_you;
    my $cheat_you_point;
    $cheat_you[0]    = 1;
    $cheat_you[1]    = 1;
    $cheat_you[2]    = 5;
    $cheat_you_point = 5;

    print "★★★自分チート★★★\n";

    print "おっと、突風が吹いた！\n\n";
    print "1回目のサイコロの眼:" . $cheat_you[0] . "\n";
    print "2回目のサイコロの眼:" . $cheat_you[1] . "\n";
    print "3回目のサイコロの眼:" . $cheat_you[2] . "\n";
    print "ゴケ。" . $cheat_you_point . "点。\n\n";

    for ( my $k = 1; $k < 4; $k++ ) {
        shift(@cheat_you);
    }

    return $cheat_you_point;
}

=pod
課題1
コンピューターの勝ちの目を潰す
現状：COMにピンゾロ、あらし、ジゴロが出たらほぼ無限ループになる。
理由：ルール上では勝ち確定になるため。実装はできてないけど
・高ポイントの役（ピンゾロ）になったら完全に無限ループなのでやばい

例）COMにピンゾロ、アラシ、ジゴロが出たら強風が吹いて賽の目が変わる等

課題2
コンピューターに3点差以内で勝つ細工を考える
現状：勝つまで回る仕様になってる
理由：圧勝すると怪しいし、かと言ってイカサマしまくりもやばい
・賽の目を変更するサブルーチンを書く
・補正値をランダムにしてプラスして勝つ等

例）インケツが出たら、ニタコorサンタで勝つ

バグ
cheat_comが読んでないのに呼ばれる箇所がある。

=cut
