# gnuplotme: gnuplot made easy

Ever wanted to plot, manipulate, and compare data. gnuplotme is a simple and intuitive front-end script for gnuplot. The idea is to be able to manipulate data very easily without the need to learn ruby, perl, gnuplot, or anything else (besides a couple of command options). Just like gnuplot, you can plot different columns from multiple files; however, you do not need to know or understand how gnuplot really works. Furthermore, similar to Excel, you can use arbitrary functions of your data and automatically take the average and plot the confidence interval of multiple files. Here is how it works.

## KEY FEATURES

* Intuitive command line to common gnuplot features
* Subsample of input data (useful in very large input files)
* Averages data from multiple input files and removes outliers
* Creates confidence interval across averaged input
* Plots any mathematical function that can be written in perl (e.g., plot your data against a closed-form function)
* Allows data series from lists or interval ranges (useful to automatically create x-axis values)
* Outputs to different formats 
* Creates both gnu file (which contains gnu script) and text file (which contains all manipulated data and is useful for later use or to import into excel)

## INSTALLATION

gnuplotme is a perl script on top of gnuplot. So, you need to have both (gnuplot and perl) installed on your system. I have successfully ran gnuplotme on Linux, Max OS X, and Cygwin on Windows XP. Here is a brief summary of steps:

* Check that perl is installed on your system (e.g., `$> perl --version`) 
* Check that gnuplot is installed on your system (e.g., `$> gnuplot --version`) 
* Download gnuplotme into your favorite directory (e.g., `/home/hani/bin`) 
* chmod gnuplotme to be executable (e.g., `chmod +x /home/hani/bin/gnuplotme`) 
* Invoke gnuplotme with fully-qualified path (e.g., `/home/hani/bin/gnuplotme`) or make sure that the directory where gnuplotme is stored (e.g., `/home/hani/bin`) is in the bin search path.

## SYNOPSIS

```
gnuplotme --help
--outfile <file_name> [eps | png | jpeg]
--file <file_name> <plot_label> <column_number>
--xlabel <x_axes_label>
--ylabel <y_axes_label> [<axis>]
--xrange <low:hi> 
--yrange <low:hi> [<axis>]
--title <title>
--key <x,y>
--percent [left,right,both]
--log_scale <x or y or xy>
--subsample <period>
```

advanced options:

```
--set <variable_name> file <filename> <column> 
--set <variable_name> range <low> <high> <step>
--set <variable_name> list <y1> <y2>< y3> ... 
--set <variable_name> avg <column> <outliers> <conf> <file1> <file2> ... 
--plot <function <plot_label> [<axis>]
--ytics <low,step,hi> [<axis>]
```

## THE BASICS

Most of the options (I hope) are self-explanatory. Let's start with the output files, which should help explain the examples here.

## OUTPUT

gnuplotme produces three files. These are: filename.data, filename.gnu, and filename.eps (or filename.png or filename.jpeg), where the `<filename>` is specified with the `--outfile` option:

```
--outfile <file_name> [eps | png | jpeg];
```

The .data file will contain the data points to be plotted. It can be imported into Excel for example for prettier plots. The .gnu file contains the script used by gnuplot to generate the third (plot) file.

Additionally, you can chose the output plot format. Currently, gnuplotme support eps, png, and jpeg. If a format is omitted, eps is used by default.

## INPUT DATA

There are a number of ways to specify input data for gnuplotme. At minimum, you should specify the values for the xaxis and one set of y values. The easiest way to specify x or y values is by using the --file command:

```
--file <file_name> <plot_label> <column_number>
```

--file specifies the column in the file <file_name> to be plotted. It also specifies the label to be used in the legend key. Important: columns in the input file can be separated by spaces or tabs (not commas).

In `--file`, if `<plot_label>` is `xaxis`, the corresponding values are used as values for the x-axis. You should specify the xaxis values first, otherwise gnuplotme gets confused.


### Simple Example:

Lets start with a simple example. This is a file (called [mydata.txt](examples/mydata.txt)) that contains the following:

```
mydata.txt:
1 5 9
2 4.6 7.2
3 2.3	6
4 1.8	5.5
5 0.7	4
6 1.5	3.2
7 2.3	2.1
8 3.1	1.6
9 4.6	0.9
10  5.5	0.2
```

Now, lets use the first column as the x-axis and the second column for the data series. I also used jpeg for output format. This way it can displayed properly on the browser:

```
gnuplotme --file [mydata.txt](examples/mydata.txt) xaxis 1 
--file [mydata.txt](examples/mydata.txt) first 2 
--outfile ex1 jpeg
```

![ex2](examples/ex2.jpg?raw=true "Example 2")
  
You can also see the other two files: the gnu file [ex2.gnu](examples/ex2.gnu) and data file [ex2.data](examples/ex2.data)

To add labels:

```
--xlabel <x_axes_label>
--ylabel <y_axes_label> [<axis>]
```

specifies the labels for the x and y axes, respectively. The label should be in quotes. For `--ylabel`, the `[<axis>]` is an optional parameter that is either `left` or `right` (default is left)

```
--title <title>
```

specifies the title of the graph, it should be in quotes. It is drawn above the graph.

Back to our example, lets add x- and y-labels:

```
gnuplotme --file [mydata.txt](examples/mydata.txt) xaxis 1 
--file [mydata.txt](examples/mydata.txt) first 2 
--file [mydata.txt](examples/mydata.txt) second 3 
--xlabel "Days"
--ylabel "Cost (USD)"
--title "Output Per Capita"
--outfile ex3 jpeg 
```

![ex3](examples/ex3.jpg?raw=true "Example 3")
  
You can also see the other two files: the gnu file [ex3.gnu](examples/ex3.gnu) and data file [ex3.data](examples/ex3.data)

Additional Controls

```
--xrange <low:hi> 
--yrange <low:hi> [<axis>]
```

specifies the range for the x and y axes, respectively the `[<axis>]` is an optional parameter that is either `left` or `right` (default is left).

```
--key <x,y>
```

specifies the location of the legend key in the graph.

```
--percent [left,right,both]
```

a simple way to make either the left or right y axes draws with scale 0 to 100, with 4 ticks every 25 points.

```
--log_scale <x or y or xy>
```

you can have the x, y, or both axes drawn in log scale.

```
--ytics <low,step,hi> [<axis>]
```

is used to change the ticks on either the left or right axes.

### Specifying data on right y-axis

All lines specified by the `--file` option are plotted on the left axis. If the right axis is desired, the `--set` and `--plot` options must be used. I'll show you an example in a little bit.

## SUBSAMPLING YOUR DATA

If a file (or variable defined below) has too many sample points, you can very easily subsample the data using the `--subsample` option.

```
--subsample <period>
```

Back to our example, lets subsample by 2 (i.e., will use every 2nd sample point in the plot):

```
gnuplotme --file [mydata.txt](examples/mydata.txt) xaxis 1 
--file [mydata.txt](examples/mydata.txt) first 2 
--file [mydata.txt](examples/mydata.txt) second 3 
--xlabel "Days"
--ylabel "Cost (USD)"
--title "Cost Per Capita"
--subsample 2
--outfile ex4 jpeg  
```

![ex4](examples/ex4.jpg?raw=true "Example 4")  
  
You can also see the other two files: the gnu file [ex4.gnu](examples/ex4.gnu) and data file [ex4.data](examples/ex4.data)

## PLOTTING MATHEMATICAL FUNCTIONS

Any mathematical function that is supported in Perl can be plotted in gnuplotme. Similar to matlab, you have to define the input variables to the function. Each variable holds a matrix of points (e.g., a column in a data file). There are three ways to define variables in gnuplotme:

* using a column in a file: `--set <variable_name> file <filename> <column>`
* using a range of values: `--set <variable_name> range <low> <high> <step>`
* using a list of values: `--set <variable_name> list <y1> <y2> <y3> ...`

For example,

```
--set x file [foo.1](examples/foo.1) 2
```

defines x as a variable with values extracted from the second column of the file [foo.1](examples/foo.1), or

```
--set x range 2 10 2
```

defines x as a variable with the values [2,4,6,8,10], or

```
--set x list 5 10 15 20 25 30
```

defines x as a variable with the values [5,10,15,20,25,30].

Once a variable is defined, the `--plot` can then be used to plot any function of the defined variables. For example:

```
gnuplotme --set x list 1 2 3 4 5 6 
--set y list 5 10 15 20 25 30 
--plot x xaxis 
--plot y RTT left
--outfile ex5 jpeg
```

will plot the values of y with a legend name of RTT and on left axis.

![ex5](examples/ex5.jpg?raw=true "Example 5")  

You can also see the other two files: the gnu file [ex5.gnu](examples/ex5.gnu) and data file [ex5.data](examples/ex5.data)

Recall, if the axis name is omitted, the left one is used by default. Here is another example is:

```
gnuplotme --set x list 1 2 3 4 5 6 
--set y list 5 10 15 20 25 30 
--plot x xaxis 
--plot x RTT left 
--plot "x**2 - y**2" Diff right
--yrange -1000:0 right
--ytics -1000,200,0 right
--outfile ex6 jpeg
```

will plot the difference between corresponding square values of x and y on the right axis.

![ex6](examples/ex6.jpg?raw=true "Example 6")

You can also see the other two files: the gnu file [ex6.gnu](examples/ex6.gnu) and data file [ex6.data](examples/ex6.data)
  
### How functions are computed?

A function takes as input one value from each variable. Notice that the functions do not allow manipulating more than one point at a time from all variables. That is, if x=[6,12,18,24,30,36], y=[5,10,15,20,25,30], and f(x,y) = x**2 - y**2 then the result will be [11,44,99,176,275,396].

gnuplotme includes some macros that operate on all values of a variable. These macros can be used in "--plot" as part of the function:

* `total_<varname>`: sum of all values of the variable varname.
* `count_<varname>`: how many points the variable has.
* `mean_<varname>`: mean value of all values of the variable varname
* `variance_<varname>`: the corresponding variance of all values.

For example,

```
gnuplotme --set x list 1 2 3 4 5 6 
--plot x xaxis 
--plot "x - mean_x" error
--outfile ex7 jpeg
```

will plot the difference between each value of x and the mean of all values, with label "error".

![ex7](examples/ex7.jpg?raw=true "Example 7")  

You can also see the other two files: the gnu file [ex7.gnu](examples/ex7.gnu) and data file [ex7.data](examples/ex7.data)

## AVERAGES, CONFIDENCE INTERVALS, AND REMOVING OUTLIERS

gnuplotme also provides simple method for averaging data from multiple files and plotting the confidence interval, if desired. This is done using the `--set` option with the avg sub-option (`--set <variable_name> avg <column <outliers> <conf> <file1> <file2> ...`)

Here is an example,

```
--set z avg 2 1 95 [foo.1](examples/foo.1) [foo.2](examples/foo.2) [foo.3](examples/foo.3) [foo.4](examples/foo.4)
```

will average the second column of files [foo.1](examples/foo.1), [foo.2](examples/foo.2), [foo.3](examples/foo.3), and [foo.4](examples/foo.4). It also computes the 95% confidence interval. Other allowed confidence values are `20`, `40`, `60`, `80`, `90`, `95`, `98`, and `99` intervals. The variable z will contain the average values of the four files, which can then be used just like any other value. The confidence interval is only plotted when the variable is specified by itself in the `--plot` command. For example,

```
gnuplotme --set x file foo.1 1
--set z avg 2 1 95 [foo.1](examples/foo.1) [foo.2](examples/foo.2) [foo.3](examples/foo.3) [foo.4](examples/foo.4)
--plot x xaxis 
--plot z avg_example
--outfile ex8 jpeg 
```

will plot the average points of the variable z with the confidence bars.
  
![ex8](examples/ex8.jpg?raw=true "Example 8")
  
You can also see the other two files: the gnu file [ex8.gnu](examples/ex8.gnu) and data file [ex8.data](examples/ex8.data)

Reminder, when plotting a function, the confidence interval is not plotted. For example,

```
--plot z**2 somename
```

will only plot the square of the average values of z.

The outlier field will remove the n highest and smallest values of each row in the specified files, where n is the specified value. This is used to remove the outliers from the collected data. In our example, we specified outlier=1 to remove the highest and lowest values.

```
--set z avg 3 2 95 foo.1 foo.2 foo.3 foo.4 foo.5 foo.6 foo.7 foo.8 foo.9 foo.10 foo.11 foo.12
```

will average the third column across the 12 files, but before computing the average, it will remove the top and bottom 2 values from each row.








