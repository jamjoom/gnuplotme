set terminal jpeg
set output "examples/ex8.jpg"
set xlabel ""
set ylabel ""
set title ""
plot "examples/ex8.data" using 1:2:3 axes x1y1 title "avg_example" with yerrorbars
