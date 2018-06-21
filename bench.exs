Benchee.run(%{
  "fast" => fn -> PhoneToString.call("408833892640883") end,
  "slow" => fn -> PhoneToString.call_slow("408833892640883") end
})
