#!/usr/bin/perl -w

die "You must provide the number of records to create. \n usage: GenerateSampleData.pl <#_of_Records> <#_of_Records_Per_Portfolio>" if @ARGV != 2;
my $NumberOfRecords = $ARGV[0];
my $RecordsPerPortfolio = $ARGV[1];

my $client =  join '', map +(q(A)..q(Z))[rand(26)], 1..10;
open(CLIENT,">Client-$client.txt") or die "$!\n";
open(OBLIGATIONS, ">Obligations/Client-$client.txt") or die "$!\n";
my $obligationCounter = 1;
my @Chars = ('1'..'9');
my $Length = 11;
my %unique=();
my $portfolio = join('', map +(q(A)..q(Z))[rand(26)], 1..10);
print STDOUT "The first portfolio is: $portfolio\n";
my $portfolio_splitter = 0;
for(my $i = 0; $i < $NumberOfRecords ; $i++ ){
    my $number = '';
    for (1..$Length) {
        $number .= $Chars[int rand @Chars];
    }
   
     if(++$portfolio_splitter % $RecordsPerPortfolio == 0){
         $portfolio = join('', map +(q(A)..q(Z))[rand(26)], 1..10);
         print STDOUT "$portfolio_splitter new portfolio: $portfolio\n";
     }
    if(exists $unique{$number}){
        $unique{$number}++;    
    }else{
        print CLIENT join("\t","Portfolio$portfolio",$number,join('', map +(q(A)..q(Z))[rand(26)], 1..10), "246.00"),"\n";
        print OBLIGATIONS join("\t",$obligationCounter++,$number,"Maintenance","123.00"),"\n";
        print OBLIGATIONS join("\t",$obligationCounter++,$number,"Loan","123.00"),"\n";
        $unique{$number}++;
    }    

}
close(CLIENT);
close(OBLIGATIONS); 

for my $k (sort keys %unique) {
    print"Not so random: $k: $unique{$k}\n" if $unique{$k} != 1;
}