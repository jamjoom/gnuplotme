set terminal jpeg
set output "examples/ex5.jpg"
set xlabel ""
set ylabel ""
set title ""
plot "examples/ex5.data" using 1:2 axes x1y1 title "RTT" with linespoint
