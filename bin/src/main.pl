#!/usr/bin/env perl

# we know 2,3,5,7 are prime
sub isPrime {
  my ($n, $ref_args, $id, $result, $len) = @_;
  return $result if($n >= $len);
  my @args = @$ref_args;
  # Or result to itself
  $result |= ($id == $args[$n] ? 1 : 0);
  return &isPrime($n+1, \@args, $id, $result, $len);
}

# find numbers who are factors
sub isPrimeFactor{
  my ($n, $ref_args, $id, $result, $len) = @_;
  return $result if($n >= $len);
  my @args = @$ref_args;
  # And results to itself
  $result &= ($id % $args[$n] != 0 ? 1 : 0);
  return &isPrimeFactor($n+1, \@args, $id, $result, $len);
}

sub mapPrime {
  my ($id, $ref_args, $len) = @_;
  my $result = 1;
  return $result if &isPrime(0, $ref_args, $id, 0, $len) == 1;
  my $r = sqrt($id);
  $result = &isPrimeFactor(0, $ref_args, $id, 1, $len);
  # find sqrt of numbers that are factors
  $result &= ($r - int($r) != 0 ? 1 : 0);
  return $result;
}

# Driver Program to test above function
sub main
{
    my ($a, $b, $c) = -1;
    my ($low, $high) = (10, 20);
    my @args = (2,3,5,7);
    printf("[INPUT] low: %d\thigh: %d\n", $low, $high);
    my @output = grep{ $c++; $c >= $low && $_ > 0}
    map{ $b++; $_ == 1 ? $b-1 : 0}
    map { ++$a >= 2 ? &mapPrime($a, \@args, 4) : 0}
        (0) x ($high);
    printf "[OUTPUT] %s\n", join(", ", @output);
}
&main;
