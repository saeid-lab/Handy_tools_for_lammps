#!/bin/bash


echo "Please enter the filename:"
read filename



grep -n -o "Atoms\|Velocities\|Masses\|Ellipsoids\|Lines\|Triangles\|Bodies\|Bonds\|Angles\|Dihedrals\|Impropers\|Atom Type Labels\|Bond Type Labels\|Angle Type Labels\|Dihedral Type Labels\|Improper Type Labels\|Pair Coeffs\|PairIJ Coeffs\|Bond Coeffs\|Angle Coeffs\|Dihedral Coeffs\|Improper Coeffs\|BondBond Coeffs\|BondAngle Coeffs\|MiddleBondTorsion Coeffs\|EndBondTorsion Coeffs\|AngleTorsion Coeffs\|AngleAngleTorsion Coeffs\|BondBond13 Coeffs\|AngleAngle Coeffs" $filename --color=always

Total=$(wc -l $filename | awk '{print $1}')
echo -e "$Total:Last line"

echo -e "\nWhat do you want to save? [Start_int:End_int]"
IFS=: 
read -r Start_int End_int

#awk "NR>=$Start_int && NR<$End_int"  $filename

awk -v "start=$Start_int" -v "End=$End_int" 'NR>=start && NR<End {print $0}' $filename

echo -e "\nDo you want to save it? [y/n]"
read answer

if [ $answer == y ]
then
    CuDate=$(date '+%Y-%m-%d-%H-%M-%S')
    echo -e "Choose a name please:"
    read name
    awk -v "start=$Start_int" -v "End=$End_int" 'NR>=start && NR<End {print $0}' $filename > $name"_"$CuDate.txt
    echo "Saved!"
else
   echo "See You Later!"
fi
