# Development of a General Jitter Function

*Commentary*

## 1 Palau test (2023-08-21)

*Initial test and result*

At SC19, John asked Arni if the current `jitter()` function can be used to
jitter ALB `par` files. The initial test involved the `jitter.R` file that was
used for the YFT 2023 assessment and a `09.par` file from a single-region ALB
model, provided by John:

- [jitter.R](function/03_yft_2023_assessment/jitter.R)
- [09.par](parfiles/alb_1_region/09.par)

The result from the test script,

- [01_yft_2023_assessment.R](tests/01_palau/01_yft_2023_assessment.R)

was an error message:

```
Error in if (flagval(par, -Selsfish[1], 48)$value == 1) { :
  argument is of length zero
```

*Small improvement while in Palau*

The error turned out to be caused by the line

```
uniqueSels <- max(flagval(par,-1:-nFish,24)$value)
```

which assumes that some fishery selectivities are grouped, but that's not the
case for the single-region ALB model. Therefore, a new and slightly improved
`jitter()` function was developed that handles the case when no fishery
selectivities are grouped:

- [jitter.R](function/04_palau/jitter.R)

The result from the test script,

- [02_palau.R](tests/01_palau/02_palau.R)

was the successful creation of 20 jittered `par` files. However, the jittered
`par` files turned out to be truncated, containing too few parameters. We were
of course hoping/expecting that the jittered `par` files would have the same
number of parameters as the original `par` file with slightly different values.

That is where the development of a general jitter function was put on hold
during SC19 in Palau (2023-08-21) as we had to turn our attention to SC19 tasks
related to the BET and YFT assessments.
