#!/umr/bin/perl -w
  $| = 1;
  srand (time|$$);

# Customize these per user
  $sig_file = "/afs/umr.edu/users/miles/sigs";
  $current_sig = "/afs/umr.edu/users/miles/.signature";
  $last_modified = "/afs/umr.edu/users/miles/.last_signature";

  $sig_output = "> $current_sig";
  $date_output = "> $last_modified";

  $today = (localtime)[6];

# Get last modified date from file
  open (LAST_MODIFIED, "$last_modified");
  $last .= <LAST_MODIFIED>;
  close LAST_MODIFIED;
  substr($last, -1, 1) = "";
	print $today;
# See if we want to change the sig
  if ($today ne $last)
  {
  # Write todays date as last modified
	 open (LAST_MODIFIED, "$date_output");
	 print LAST_MODIFIED "$today\n";
	 close (LAST_MODIFIED);
  # Write new sig
	 open (CURRENT_SIG, "$sig_output");
 	 print CURRENT_SIG &get_sig($sig_file);
	 close (CURRENT_SIG);
  } 

sub get_sig
{
  local ($sig_file) = @_; 
  open (SIG_FILE, "$sig_file");

  while (<SIG_FILE>)
  {
    if ($_ ne "%%\n")
    {
      $sig .= "$_";
    } else {
      push (@sigs, $sig);
      $sig = "";
    }
  }

  close (SIG_FILE);
  splice(@sigs,int(rand(@sigs)),1)."\n";
}

