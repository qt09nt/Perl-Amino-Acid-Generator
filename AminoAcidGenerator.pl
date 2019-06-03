#I declare that the attached assignment is wholly my own work in accordance with Seneca Academic Policy. No part of this assignment has been copied manually or electronically from any other source (including web sites) or distributed to other students. 

#!/usr/bin/perl
use strict;											
use warnings;

my @elements = ("H", "O", "N", "C");					#array for elements
my @atomicValence = ((+1), (-2), (-3), (-4)); 			#array for atomic valence  
my @atomicMass = (1.0079, 15.9994, 14.0067, 12.0107);	#array for atomic mass

my @atomTypeArray = (1, 2, 3, 4);    #array is used to generate an atom at random, where 1 = hydrogen, 2 = oxygen, 3 = nitrogen, 4 = carbon
my $randomAtom = -1;   

my $h=0;	#variable for counting the number of hydrogen atoms
my $o=0;	#variable for counting the number of oxygen atoms
my $n=0;	#variable for counting the number of nitrogen atoms
my $c=0; 	#this is a counter for the number of carbon atoms

my $atomicValence = 0;		#variable for the atomic valence
my $bondValue = 0;			#variable for counting the original bond value
my $totalBondValue = 0;		#variable for counting the total bond value after a new atomic valence is added

my $hydrogenMass = 0;		#counts the total mass of the hydrogen atoms; initialize this numeric variable
my $oxygenMass = 0;			#counts the total mass of the oxygen atoms
my $nitrogenMass = 0;		#counts the total mass of the nitrogen atoms
my $carbonMass = 0;			#counts the total mass of the carbon atoms
my $totalMolecularMass = 0; #counts the total molecular mass 

my $compoundFormula = "";	#initializes variable for new compound formula

my %aminoAcidFormula = (	#hash set up for Amino Acid Molecular Formulas
	C3H7N1O2	  => 'Alanine',
	C4H7N1O4	  => 'AsparticAcid',      
	C5H9N1O4	  => 'GlutamicAcid',
	C9H11N1O2     => 'Phenylalanine',
	C2H5N1O2      => 'Glycine',
	C6H9N3O2      => 'Histidine ',
    C6H13N1O2     => 'Isoleucine',
	C6H14N2O2     => 'Lysine',
	C6H13N1O2     => 'Leucine',
	C4H8N2O3      => 'Asparagine',
	C5H9N1O2      => 'Proline',
	C5H10N2O3     => 'Glutamine',       
	C6H14N4O2     => 'Arginine',       
	C3H7N1O3 	  => 'Serine',         
    C4H9N1O3 	  => 'Threonine',         
	C5H11N1O2	  => 'Valine',       
	C11H12N2O2 	  => 'Tryptophan',      
	C9H11N1O3 	  => 'Tyrosine'   
);

my $yearCounter = 0;	#counts the years
my $lastYearOnEarth = 3800000000;	#3.8 billion years, the year in which the program should be terminated

while ($yearCounter < $lastYearOnEarth) {
	$randomAtom = $atomTypeArray [rand @atomTypeArray];				#generate a random atom from the Atom Type Array
	$yearCounter ++;												#Increase the year by 1, each time the program goes through this loop
	
	if ($randomAtom == 1){ 										#condition for the random generation of an atom being hydrogen
		$bondValue = $bondValue + $atomicValence [0];			#$bondValue is assigned the value of +1 if hydrogen is the randomly picked atom ($atomicValence [0])
		$hydrogenMass += $atomicMass[0]; 						#adds the atomic mass of hydrogen to the variable $hydrogenMass which counts the total mass of hydrogen atoms generated
		$h++;													#counter for the total number of hydrogen atoms
	} elsif ($randomAtom == 2){									#condition for the random generation of an atom being oxygen
		if ($bondValue >= 0) { 									#condition for positive bond values
			$bondValue = $bondValue + $atomicValence [1];			#$bondValue is assigned the value of -2 if oxygen is the randomly picked atom ($atomicValence [1])
			$oxygenMass += $atomicMass[1];							#adds the atomic mass of oxygen to the variable $oxygenMass which counts the total mass of oxygen atoms generated
			$o++;
		}														#counter for the total number of oxygen atoms
		if ($bondValue < 0) {								#adding an atom of oxygen to a negative bond value
			$bondValue = $bondValue + ($atomicValence [1] + 2);		#bond value will decrease by the valence of the oxygen atom +2 
			$oxygenMass += $atomicMass [1];							#counter for the total number of oxygen atoms; will increase by the mass of one oxygen atom each time an oxygen atom is added
			$o++;													#total number of oxygen atoms increase by 1 each time an oxygen atom is added		
		}
	} elsif ($randomAtom == 3){									#condition for the random generation of an atom being nitrogen
		if ($bondValue >= 0) { 									#this condition is for adding an atom of nitrogen, when bond value is positive
			$bondValue = $bondValue + $atomicValence [2] ;			#$bondValue is assigned the value of -3 if nitrogen is the randomly picked atom ($atomicValence [2])
			$nitrogenMass += $atomicMass[2];						#adds the atomic mass of nitrogen to the variable $nitrogenMass which counts the total mass of nitrogen atoms generated
			$n++;													#counter for the total number of nitrogen atoms increases by 1 each time a nitrogen is added
		}
		if ($bondValue < 0) {								#adding an atom of nitrogen to a negative bond value
			$bondValue = $bondValue + ($atomicValence [2] +2);		#bond value will decrease by valence of a nitrogen atom +2
			$nitrogenMass += $atomicMass[2];						#total mass of nitrogen atoms increases by the mass of a nitrogen atom each time a nitrogen atom is added
			$n++;													#counter for total number of nitrogen atoms increases by 1 each time a nitrogen is added
		}
	} elsif ($randomAtom == 4){									#condition for the random generation of a carbon atom 
		if ($c % 3 == 0) {									#checks whether the newly generated carbon is one of every three carbons generated
			if ($bondValue >= 0) {								#conditions for positive bond values
				$bondValue +=  ($atomicValence [3] +2);				#$bondValue is assigned the value of -4 if carbon is the randomly picked atom ($atomicValence [3])
				$carbonMass += $atomicMass[3];						#adds the atomic mass of carbon to the variable $carbonMass which counts the total mass of carbon atoms generated
				$c++;												#counter for the total number of carbon atoms increases by one 
			} 
			if ($bondValue < 0){								#condition for adding a carbon atom when bond value is negative
				$bondValue = $bondValue;							#bond value will remain unchanged for negative bond values for every third carbon generated
				$carbonMass += $atomicMass[3];						#increases total mass of carbon by the mass of one carbon atom
				$c++;
			}													#total number of carbon atoms increases by 1 
		} else {											    #conditions for a randomly generated carbon atom that is NOT one of every third carbons generated
			if ($bondValue >= 0) {								#conditions for positive bond values
				$bondValue +=  ($atomicValence [3]);				#$bondValue is assigned the value of -4 if carbon is the randomly picked atom ($atomicValence [3])
				$carbonMass += $atomicMass[3];						#adds the atomic mass of carbon to the variable $carbonMass which counts the total mass of carbon atoms generated
				$c++;												#counter for the total number of carbon atoms increases by 1 
			}
			if ($bondValue < 0){								#condition for adding a carbon atom when bond value is negative
				$bondValue = $bondValue + ($atomicValence [3] +2);	#bond value will decrease by valence of carbon + 2 units
				$carbonMass += $atomicMass[3];						#increases total mass of carbon by the mass of one carbon atom
				$c++;												#total number of carbon atoms increases by 1
			}
		}
	}
	if ($bondValue < -4) {					#when bond value falls below -4
		$h += +3; 								#add 3 hydrogen atoms to the counter for hydrogen atoms
		$bondValue += +3;						#increase the bond value by 3 units to make it more positive
		$hydrogenMass += (3 * $atomicMass[0]);	#increase the total mass of hydrogen by 3 times the atomic mass of hydrogen	
	}
	if ($bondValue == 0 || ($hydrogenMass + $oxygenMass + $nitrogenMass + $carbonMass )> 204.2247 ) {	#condition for creation of a stable compound with bond of 0, or if the total molecular mass exceeds 204.2247
			print ("compound: H$h"."O$o"."N$n"."C$c  Mol wt.: $totalMolecularMass amino acid: N/A The year is now $yearCounter\n");	#displays output of molecular formula, molecular mass and failure to produce an amino acid 
			 		
			$hydrogenMass = 0;		#reset the molecular mass to zero, so that new atoms generated will not add to the molecular mass of the stable ggcompound produced in the previous step	
			$oxygenMass = 0;
			$nitrogenMass = 0;
			$carbonMass = 0;
			
			$bondValue = 0;		#reset the bond value back to zero
			
			$h=0;			#reset the counter for number of hydrogen atoms back to zero						
			$o=0;			#reset the counter for number of oxygen atoms back to zero 
			$n=0;			#reset the counter for the number of nitrogen atoms back to zero 
			$c=0;			#reset the counter for the number of carbon atoms back to zero
	}
		
	$totalMolecularMass = $hydrogenMass + $oxygenMass + $nitrogenMass + $carbonMass;	#counts total molecular mass of new compound generated	
	my $compoundFormula = "C$c"."H$h"."N$n"."O$o";
	
	
	if(exists($aminoAcidFormula{$compoundFormula})){				#Searches amino acid hash to see if compound formula matches any of the entries in the hash
		print("Amino acid formed: $aminoAcidFormula{$compoundFormula}, $compoundFormula\n");	#outputs that an amino acid is formed, along with the name of the amino acid
		last;
	}

}

if ($yearCounter == 3800000000) {								#when the year reaches 3.8 billion years, this will terminate the program 
	print "The year is now 3800,000,000. Life never formed on planet Earth!";
}
