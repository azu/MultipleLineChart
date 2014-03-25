# グラフのデザイン

## データ・モデル

グラフのデータに共通するのは以下の項目

`<GraphValueModel>`

* データ量

グラフは グラフデータをまとめた `<GraphGroupDataSource>` の配列を持つ

`<GraphGroupDataSource>` は

* `<GraphValueModel>` の配列
* ラベルとなる文字列 の配列

を持つ(両項目は同じ数とする)

つまり、ひとつのグラフに複数の種類の線が引ける。

* グラフのDataSource
    * [ ラベルとなる文字列 ]
    * [`<GraphGroupDataSource>`]
        * [`<GraphValueModel>`]

## グラフのView

グラフは前現在後の3つのポイントのデータを持つ

`LineChartPlotData` のインスタンスにそれぞれ入れてやりとりする。