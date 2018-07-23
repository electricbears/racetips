# Include file for betting models

# Model v1
model_v1() # Original model, cascade rules
{
   message="Nope (0)"

   [ $confidence -gt 60 ] && \
   [ $win_tips_count -gt 7 ] && \
      message="Good (1)" && \
   [ "$tipOnATR" == "Yes" ] && \
      message="Better (2)" && \
   [ ! -z "$racingPostNap" ] && \
      message="Best (3)" && \
   [ ${racingPostLevelStakes/\./} -gt 0 ] && \
      message="Bestest (4)"
	echo $message
}

# Model v2
model_v2() # Confidence driven, considers ATR tips
{
   message="Nope (0)"
   [ $confidence -lt 60 ] && message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Maybe (1)" # Maybe (1)
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && message="Good (2)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Better (3)"
   [ $confidence -ge 60 ] && message="Maybe (1a)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Watch" ] && message="Maybe (1b)" # Maybe (1b)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Best (4)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Bestest (5)"

	echo $message
}	

model_v2a() # Each rule from model v2 in v2[a-g]
{  
   message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Good (1)" # Maybe (1)
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && message="Nope (0)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1b)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   echo $message
}

model_v2b() # Each rule from model v2 in v2[a-g]
{  
   message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1)
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && message="Good (1)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && message="Nope (0)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1b)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   echo $message
}

model_v2c() # Each rule from model v2 in v2[a-g]
{  
   message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1)
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Good (1)"
   [ $confidence -ge 60 ] && message="Nope (0)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1b)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   echo $message
}

model_v2d() # Each rule from model v2 in v2[a-g]
{  
   message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1)
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && message="Good (1)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1b)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   echo $message
}

model_v2e() # Each rule from model v2 in v2[a-g]
{  
   message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1)
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && message="Nope (0)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Watch" ] && message="Good (1)" # Maybe (1b)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   echo $message
}

model_v2f() # Each rule from model v2 in v2[a-g]
{  
   message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1)
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && message="Nope (0)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1b)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Good (1)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   echo $message
}

model_v2g() # Each rule from model v2 in v2[a-g]
{  
   message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1)
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && message="Nope (0)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Watch" ] && message="Nope (0)" # Maybe (1b)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Nope (0)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Good (1)"
   echo $message
}

	# Model v3
model_v3() # Rubbish model
{
   message="Nope (0)"
   [ $confidence -gt 68 ] && [ "$atrTipType" == "Top tip" ] && message="Best (1)"
   [ $confidence -gt 68 ] && [ "$atrTipType" == "" ] && [ $confidence_nap -le 84 ] && message="Best (1)"

   [ $confidence -le 68 ] && [ $win_tips -gt 24 ] && message="Best (1)"

	echo $message
}

# Model v4
model_v4() # ATR "Watch" biased
{
   message="Nope (0)"
   [ "$atrTipType" == "Watch" ] && message="Bestest (5)"
   [ $confidence -gt 68 ] && message="Bestest (5)"
   [ $confidence -le 68 ] && [ $win_tips -gt 24 ] && message="Best (1)"
   #[ $confidence -le 68 ] && [ $confidence_ew -gt 2 ] && message="Best (1)"
   [ $confidence -gt 56 ] && [ "$atrTipType" == "Top tip" ] && message="Best (1)"

	echo $message
}

model_v5() # RP nap with positive level stakes
{
   message="Nope (0)"
	[ ! -z "$racingPostNap" ] && echo $racingPostLevelStakes|grep -vq "-" && message="Bestest (5)"

	echo $message
}

model_v6() # Best rules from model_v2
{
   message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Maybe (1)" # Maybe (1)
   [ $confidence -ge 60 ] && message="Maybe (1a)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Best (4)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Bestest (5)"
   echo $message
}

model_v7() # Refresh of best rules from model_v2
{
   message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Good (1)" # Maybe (1)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Good (1)"
   [ $confidence -ge 60 ] && message="Good (1)" # Maybe (1a)
   [ $confidence_nap -ge 70 ] && message="Good (1)" # Maybe (1a)
   echo $message
}

model_v8() # Confidence nap
{
   message="Nope (0)"
   [ $confidence_ew -gt 3 ] && [ "$tipOnATR" = "No" ] && message="Good (1)"
   [ $confidence_ew -gt 3 ] && [ "$tipOnATR" = "Yes" ] && [ $confidence_ew -gt 29 ] && $confidence_nap -ge 70 ] && message="Good (1)"
   [ $confidence_ew -gt 3 ] && [ "$tipOnATR" = "Yes" ] && [ $confidence_ew -gt 29 ] && $confidence_nap -ge 70 ] && message="Good (1)"
   [ $confidence_ew -gt 3 ] && [ "$tipOnATR" = "Yes" ] && [ $confidence_ew -le 29 ] && $confidence_nap -le 31 ] && message="Good (1)"
   [ $confidence_ew -le 3 ] && [ "$tipOnATR" = "Yes" ] && message="Good (1)"
   echo $message
}

# Model v2
model_v9() # Confidence driven, considers ATR tips
{
   message="Nope (0)"
   [ $confidence -lt 60 ] && message="Nope (0)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Watch" ] && message="Maybe (1)" # Maybe (1)
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && message="Good (2)"
   [ $confidence -lt 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Better (3)"
   [ $confidence -ge 60 ] && message="Maybe (1a)" # Maybe (1a)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Watch" ] && message="Maybe (1b)" # Maybe (1b)
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && message="Best (4)"
   [ $confidence -ge 60 ] && [ "$atrTipType" == "Top tip" ] && [ ! -z "$racingPostNap" ] && message="Bestest (5)"

	echo $message
}	
# Model v2
model_v10() # Confidence driven, considers ATR tips
{
   message="Nope (0)"
   [ $confidence -ge 69 ] && [ "$atrTipType" == "" ] && [ "$racingPostNap" == "" ] && message="Maybe (1a)" # Maybe (1a)
	echo $message
}	


model_v11() # Confidence driven, considers ATR tips
{
   message="Nope (0)"
   #[ $confidence -ge 60 ] && message="Good (1)"
   [ $confidence -ge 60 ] && [ $ew_tips -lt 1 ] && [ $ew_tips_count -ge 10 ] && message="Good (1)"
	echo $message
}	
