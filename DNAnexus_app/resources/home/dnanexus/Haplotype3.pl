#!/usr/bin/env perl





use strict;


use warnings;





my $InputVariantFile = $ARGV[1];


my $InputBam = $ARGV[0];


my $ReadLength = $ARGV[2];


open (LOG3, "> OutputSam.0.sam") || die "Cannot open OutputSam.0.sam";


open (LOG7, "> OutputSam.1.sam") || die "Cannot open OutputSam.1.sam";


my $header = `samtools view -H "$InputBam"`;


print LOG3 "$header";


print LOG7 "$header";





my @InputVariantsChrom;


my @InputVariantsPos;


my @InputRef;


my @InputAlt;


my @InputPhaseRef;


my @InputPhaseAlt;





open (LOG, "$InputVariantFile") || die "Cannot open $InputVariantFile";


while (<LOG>) {


	chomp;


	my ($tempChr,$tempPos,$tempref,$tempalt,$tempphaseRef,$tempphaseAlt) =  split(/\t/);


	push(@InputVariantsChrom,$tempChr);


	push(@InputVariantsPos,$tempPos);


	push(@InputRef,$tempref);


	push(@InputAlt,$tempalt);


	push(@InputPhaseRef,$tempphaseRef);


	push(@InputPhaseAlt,$tempphaseAlt);


	}


close (LOG);





my $NumVariants = @InputVariantsChrom;





my $counter = 0;


while ($counter<$NumVariants) {


	


#########################################################################


my $SamtoolsViewOutput = `samtools view "$InputBam" "$InputVariantsChrom[$counter]":"$InputVariantsPos[$counter]"-"$InputVariantsPos[$counter]"`;





my @lines = split(/\n/,$SamtoolsViewOutput);





my @Reads;


my @Phase;


foreach my $a (@lines) {


	my($ReadID,$fill,$fill2,$tempos2,$fill3,$match,$fill5,$fill6,$fill7,$tempSeq) = split(/\t/,$a);


	my $offset = abs($tempos2-$InputVariantsPos[$counter]);


	my $criticalbase = substr($tempSeq,$offset,1);


	my $tempphase = 2;


	if (($criticalbase eq $InputRef[$counter]) && ($match eq "${ReadLength}M")) {


		$tempphase = $InputPhaseRef[$counter];


		} elsif (($criticalbase eq $InputAlt[$counter]) && ($match eq "${ReadLength}M")) {


		$tempphase = $InputPhaseAlt[$counter];


		}


	push(@Reads,$ReadID);


	push(@Phase,$tempphase);


	}





my $upperbound = $InputVariantsPos[$counter]-500;


my $lowerbound = $InputVariantsPos[$counter]+500;


my $tempSam = `samtools view "$InputBam" "$InputVariantsChrom[$counter]":"$upperbound"-"$lowerbound"`;


open (LOG1, "> TempSam.sam") || die "Cannot open TempSam";


print LOG1 "$tempSam";


close (LOG1);





open (LOG6, "TempSam.sam") || die "Cannot open Tempsam.sam";


my @TempSam;


while (<LOG6>) {


	push(@TempSam,$_);


	}


close (LOG6);





my $readcounter=0;


foreach my $d (@Reads) {


	my $howmanypair=0;


	my $currentphase = $Phase[$readcounter];


	foreach my $e (@TempSam) {


		if (($e =~ /$d/) && ($currentphase == 0)) {


			my $printout = $e;


			print LOG3 "$printout";


			$howmanypair++;


			if ($howmanypair == 2) {


				last;


				}


			} elsif (($e =~ /$d/) && ($currentphase == 1)) {


			my $printout = $e;


			print LOG7 "$printout";


			$howmanypair++;


			if ($howmanypair == 2) {


				last;


				}


			}


		}


	$readcounter++;	


	}





#########################################################################


	$counter++;


	my $fractioncomplete = $counter/$NumVariants*100;


	print "Currently, ";


	print "$fractioncomplete";


	print " percent complete\n";


	}





close (LOG3);


close (LOG7);





`samtools view -bh OutputSam.0.sam > OutputBam.0.bam`;


`samtools view -bh OutputSam.1.sam > OutputBam.1.bam`;





`samtools sort -n OutputBam.0.bam > SortedByNameOutputBam.0.bam`;


`samtools sort -n OutputBam.1.bam > SortedByNameOutputBam.1.bam`;





`rm OutputSam.0.sam`;


`rm OutputSam.1.sam`;





`rm OutputBam.0.bam`;


`rm OutputBam.1.bam`;





`rm TempSam.sam`;





`samtools view SortedByNameOutputBam.0.bam > SortedByNameOutputSam.0.sam`;


`samtools view SortedByNameOutputBam.1.bam > SortedByNameOutputSam.1.sam`;





`rm SortedByNameOutputBam.0.bam`;


`rm SortedByNameOutputBam.1.bam`;





open (LOG4, "SortedByNameOutputSam.0.sam") || die "Cannot open SortedByNameOutputSam.0.sam";


open (LOG8, "SortedByNameOutputSam.1.sam") || die "Cannot open SortedByNameOutputSam.1.sam";





open (LOG5, "> FilteredSortedByNameOutputSam.0.sam") || die "Cannot open FilteredSortedByNameOutputSam.0.sam";


print LOG5 "$header";


my $lastline="null";


while (<LOG4>) {


	if ($_ ne $lastline) {


		print LOG5 "$_";


		}


	$lastline=$_;


	}


	


open (LOG9, "> FilteredSortedByNameOutputSam.1.sam") || die "Cannot open FilteredSortedByNameOutputSam.1.sam";


print LOG9 "$header";


my $lastline1="null";


while (<LOG8>) {


	if ($_ ne $lastline1) {


		print LOG9 "$_";


		}


	$lastline1=$_;


	}


	


close (LOG4);


close (LOG8);





close (LOG5);


close (LOG9);





`rm SortedByNameOutputSam.0.sam`;


`rm SortedByNameOutputSam.1.sam`;





`samtools view -bh FilteredSortedByNameOutputSam.0.sam > FilteredSortedByNameOutputBam.0.bam`;


`samtools view -bh FilteredSortedByNameOutputSam.1.sam > FilteredSortedByNameOutputBam.1.bam`;





`rm FilteredSortedByNameOutputSam.0.sam`;


`rm FilteredSortedByNameOutputSam.1.sam`;





`samtools sort FilteredSortedByNameOutputBam.0.bam > SortedFiltered.0.bam`;


`samtools sort FilteredSortedByNameOutputBam.1.bam > SortedFiltered.1.bam`;





`samtools index SortedFiltered.0.bam`;


`samtools index SortedFiltered.1.bam`;





`rm FilteredSortedByNameOutputBam.0.bam`;


`rm FilteredSortedByNameOutputBam.1.bam`;


