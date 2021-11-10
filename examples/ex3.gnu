set terminal jpeg
set output "examples/ex3.jpg"
set xlabel "Days"
set ylabel "Cost (USD)"
set title "Output Per Capita"
plot "examples/ex3.data" using 1:2 axes x1y1 title "first" with linespoint, "examples/ex3.data" using 1:3 axes x1y1 title "second" with linespoint
