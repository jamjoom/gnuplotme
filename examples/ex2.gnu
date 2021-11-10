set terminal jpeg
set output "examples/ex2.jpg"
set xlabel ""
set ylabel ""
set title ""
plot "examples/ex2.data" using 1:2 axes x1y1 title "first" with linespoint, "examples/ex2.data" using 1:3 axes x1y1 title "second" with linespoint
