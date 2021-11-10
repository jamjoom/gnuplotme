set terminal jpeg
set output "examples/ex7.jpg"
set xlabel ""
set ylabel ""
set title ""
plot "examples/ex7.data" using 1:2 axes x1y1 title "error" with linespoint
