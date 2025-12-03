use strict;
use warnings;

sub is_abba {
  my ($ip7) = @_;
  
  for (my $i = 0; $i < length($ip7) - 3; $i++) {
    if ((substr($ip7, $i, 2) eq (reverse substr($ip7, $i + 2, 2))) && (substr($ip7, $i, 1) ne substr($ip7, $i + 1, 1))) {
      return 1;
    }
  }
  return 0;
}

sub is_tls {
  my ($line) = @_;
  my @groups = split(/(?=\[)|((?<=\]))/, $line);
  my $has_abba = 0;
  foreach my $grouping (@groups) {
    if ($grouping && $grouping =~ /^\[([a-z]+)\]$/) {
      if (is_abba($1)) {
        return 0;
      }
    } elsif ($grouping && is_abba($grouping)) {
      $has_abba = 1;
    }
  }
  return $has_abba;
}

sub is_ssl {
  my ($line) = @_;
  
  my $inside_hypernet_sequence = 0;
  for (my $i = 0; $i < length($line) - 2; $i++) {
    if (substr($line, $i, 1) eq "[") {
      $inside_hypernet_sequence = 1;
    } elsif (substr($line, $i, 1) eq "]") {
      $inside_hypernet_sequence = 0;
    } elsif (!$inside_hypernet_sequence &&
          substr($line, $i, 1) eq substr($line, $i + 2, 1) &&
          substr($line, $i, 1) ne substr($line, $i + 1, 1) &&
          substr($line, $i + 1, 1) ne "[" &&
          substr($line, $i + 1, 1) ne "]") {
      my $matching_bab = substr($line, $i + 1, 1) . substr($line, $i, 1) . substr($line, $i + 1, 1);
      print "Searching " . $matching_bab . "\n";
      if ($line =~ qr/\[[a-z]*$matching_bab[a-z]*\]/) {
        print "Found\n";
        return 1;
      }
    }
  }
  return 0;
}

sub solve {
  my ($linesStr) = @_;
  
  my @lines = split(/\n/, $linesStr);
  
  my $tls_count = 0;
  my $ssl_count = 0;
  my $count = 0;
  foreach my $line (@lines) {
    print "\n\n" . $line . "\n";
    if (is_tls($line)) {
      $tls_count += 1;
    }
    
    if (is_ssl($line)) {
      $ssl_count += 1;
    }
  }
  print $tls_count . "\n";
  print $ssl_count . "\n";
}
