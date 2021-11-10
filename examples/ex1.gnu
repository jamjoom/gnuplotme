set terminal jpeg
set output "examples/ex1.jpg"
set xlabel ""
set ylabel ""
set title ""
plot "examples/ex1.data" using 1:2 axes x1y1 title "first" with linespoint
