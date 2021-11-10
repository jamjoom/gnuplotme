set terminal jpeg
set output "examples/ex6.jpg"
set xlabel ""
set ylabel ""
set title ""
set y2range [-1000:0]
set y2tics -1000,200,0
plot "examples/ex6.data" using 1:2 axes x1y1 title "RTT" with linespoint, "examples/ex6.data" using 1:3 axes x1y2 title "Diff" with linespoint
