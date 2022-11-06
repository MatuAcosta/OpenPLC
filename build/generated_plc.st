PROGRAM prueba
  VAR
    sensor_hall AT %IX0.0 : BOOL := 0;
    led AT %QX0.0 : BOOL := 1;
    led_rojo AT %QX0.2 : BOOL := 0;
    rele AT %QX0.1 : BOOL := 0;
  END_VAR
  VAR
    subir_pist : TP;
    counter : CTU;
    delay : TON;
    bajar_pist : TP;
    _TMP_NOT10_OUT : BOOL;
    R_TRIG1 : R_TRIG;
    _TMP_NOT16_OUT : BOOL;
  END_VAR

  _TMP_NOT10_OUT := NOT(sensor_hall);
  R_TRIG1(CLK := _TMP_NOT10_OUT);
  delay(IN := counter.Q, PT := T#12000ms);
  counter(CU := R_TRIG1.Q, R := delay.Q, PV := 5);
  subir_pist(IN := counter.Q, PT := T#2000ms);
  bajar_pist(IN := delay.Q, PT := T#2000ms);
  rele := bajar_pist.Q OR subir_pist.Q;
  led_rojo := counter.Q;
  _TMP_NOT16_OUT := NOT(counter.Q);
  led := _TMP_NOT16_OUT OR _TMP_NOT16_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : prueba;
  END_RESOURCE
END_CONFIGURATION
