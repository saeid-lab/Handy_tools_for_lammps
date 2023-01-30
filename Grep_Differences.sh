#!/bin/bash

# For bonds :

echo "Please enter the first filename:"
read file1

echo "Please enter the second filename:"
read file2

# -------------- file1  -------------- #
s_bond1=58
e_bond1=82

s_angle1=82
e_angle1=122

s_dihedral1=122
e_dihedral1=168

s_impropers1=168
e_impropers1=171
# -------------- file2  -------------- #
s_bond2=214
e_bond2=237

s_angle2=237
e_angle2=274

s_dihedral2=274
e_dihedral2=314

s_impropers2=314
e_impropers2=316


awk "NR>=$s_bond1 && NR<$e_bond1" $file1 > Bonds_1.tmp1
awk "NR>=$s_angle1 && NR<$e_angle1" $file1 > Angles_1.tmp1
awk "NR>=$s_dihedral1 && NR<$e_dihedral1" $file1 > Dihedrals_1.tmp1
awk "NR>=$s_impropers1 && NR<$e_impropers1" $file1 > Impropers_1.tmp1

awk "NR>=$s_bond2 && NR<$e_bond2" $file2 > Bonds_2.tmp2
awk "NR>=$s_angle2 && NR<$e_angle2" $file2 > Angles_2.tmp2
awk "NR>=$s_dihedral2 && NR<$e_dihedral2" $file2 > Dihedrals_2.tmp2
awk "NR>=$s_impropers2 && NR<$e_impropers2" $file2 > Impropers_2.tmp2

awk '{print $2,$3,$4}' Bonds_1.tmp1 | sort -k2 -n > Bond_1_Sorted.tmp1
awk '{print $2,$3,$4}' Bonds_2.tmp2 | sort -k2 -n > Bond_2_Sorted.tmp2
echo "Bond Differences:" >> Diff.txt
diff Bond_1_Sorted.tmp1 Bond_2_Sorted.tmp2 >> Diff.txt

awk '{print $2,$3,$4,$5}' Angles_1.tmp1 | sort -k2 -n > Angles_1_Sorted.tmp1
awk '{print $2,$3,$4,$5}' Angles_2.tmp2 | sort -k2 -n > Angles_2_Sorted.tmp2
echo "Angle Differences:" >> Diff.txt
diff Angles_1_Sorted.tmp1 Angles_2_Sorted.tmp2 >> Diff.txt

awk '{print $2,$3,$4,$5,$6}' Dihedrals_1.tmp1 | sort -k2 -n > Dihedrals_Sorted.tmp1
awk '{print $2,$3,$4,$5,$6}' Dihedrals_2.tmp2 | sort -k2 -n > Dihedrals_Sorted.tmp2
echo "Dihedral Differences:" >> Diff.txt
diff Dihedrals_Sorted.tmp1 Dihedrals_Sorted.tmp2 >> Diff.txt

awk '{print $2,$3,$4,$5,$6}' Impropers_1.tmp1 | sort -k2 -n > Impropers_1_Sorted.tmp1
awk '{print $2,$3,$4,$5,$6}' Impropers_2.tmp2 | sort -k2 -n > Impropers_2_Sorted.tmp2
echo "Improper Differences:" >> Diff.txt
diff Impropers_1_Sorted.tmp1 Impropers_2_Sorted.tmp2 >> Diff.txt


rm *.tmp1
rm *.tmp2
