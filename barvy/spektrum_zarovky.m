function [wavelengths, power] = spektrum_zarovky()

% Vraci spektrum zarovky
% (Data dodal v unoru 2020 Jan Skoda, FEKT)

% (c) 2020 Pavel Rajmic, Brno University of Technology, Czech Republic

%Wavelength [nm]	Normalizovany vykon [W/nm]
matrix = [...
380 	0.021377
381 	0.022006
382 	0.022635
383 	0.023037
384 	0.023369
385 	0.023701
386 	0.0242
387 	0.024698
388 	0.025028
389 	0.025357
390 	0.02612
391 	0.026882
392 	0.027617
393 	0.028352
394 	0.029382
395 	0.030411
396 	0.031435
397 	0.032459
398 	0.033877
399 	0.034852
400 	0.035827
401 	0.036472
402 	0.037116
403 	0.038173
404 	0.03923
405 	0.040342
406 	0.041454
407 	0.042681
408 	0.043908
409 	0.045103
410 	0.046297
411 	0.047638
412 	0.04898
413 	0.051044
414 	0.052142
415 	0.053241
416 	0.054408
417 	0.055575
418 	0.056958
419 	0.058341
420 	0.059807
421 	0.061272
422 	0.062521
423 	0.06377
424 	0.065099
425 	0.066428
426 	0.067748
427 	0.069068
428 	0.071426
429 	0.072679
430 	0.073932
431 	0.075131
432 	0.07633
433 	0.077718
434 	0.079105
435 	0.080238
436 	0.081371
437 	0.08273
438 	0.084089
439 	0.086103
440 	0.088116
441 	0.090954
442 	0.09249
443 	0.094026
444 	0.09567
445 	0.097315
446 	0.09917
447 	0.101025
448 	0.102794
449 	0.104563
450 	0.106291
451 	0.10802
452 	0.109743
453 	0.111466
454 	0.114832
455 	0.116362
456 	0.117892
457 	0.119879
458 	0.121867
459 	0.123798
460 	0.125729
461 	0.127587
462 	0.129445
463 	0.131168
464 	0.132892
465 	0.134707
466 	0.136523
467 	0.139455
468 	0.141347
469 	0.14324
470 	0.145183
471 	0.147126
472 	0.149279
473 	0.151433
474 	0.153565
475 	0.155697
476 	0.157694
477 	0.15969
478 	0.163988
479 	0.166103
480 	0.168217
481 	0.170183
482 	0.172149
483 	0.174135
484 	0.17612
485 	0.178146
486 	0.180171
487 	0.182081
488 	0.183991
489 	0.188118
490 	0.190243
491 	0.192368
492 	0.194479
493 	0.19659
494 	0.198813
495 	0.201036
496 	0.203278
497 	0.205521
498 	0.207693
499 	0.209866
500 	0.2146
501 	0.217205
502 	0.21981
503 	0.222322
504 	0.224834
505 	0.227247
506 	0.22966
507 	0.232252
508 	0.234844
509 	0.237422
510 	0.24
511 	0.244977
512 	0.247378
513 	0.249778
514 	0.252087
515 	0.254397
516 	0.256804
517 	0.25921
518 	0.261389
519 	0.263567
520 	0.268981
521 	0.271647
522 	0.274313
523 	0.276942
524 	0.279572
525 	0.28209
526 	0.284608
527 	0.287267
528 	0.289925
529 	0.295219
530 	0.297794
531 	0.300369
532 	0.302773
533 	0.305177
534 	0.307906
535 	0.310635
536 	0.313374
537 	0.316113
538 	0.321475
539 	0.324119
540 	0.326763
541 	0.329468
542 	0.332174
543 	0.334574
544 	0.336974
545 	0.33955
546 	0.342126
547 	0.347238
548 	0.350185
549 	0.353132
550 	0.355683
551 	0.358235
552 	0.360778
553 	0.363322
554 	0.36582
555 	0.368319
556 	0.373182
557 	0.37608
558 	0.378979
559 	0.381435
560 	0.383892
561 	0.386473
562 	0.389053
563 	0.394378
564 	0.397353
565 	0.400328
566 	0.403029
567 	0.40573
568 	0.408347
569 	0.410965
570 	0.413752
571 	0.416539
572 	0.422482
573 	0.425342
574 	0.428201
575 	0.431236
576 	0.434271
577 	0.437026
578 	0.43978
579 	0.445243
580 	0.447964
581 	0.450685
582 	0.453622
583 	0.456559
584 	0.459343
585 	0.462127
586 	0.468082
587 	0.470737
588 	0.473391
589 	0.476525
590 	0.479658
591 	0.482579
592 	0.4855
593 	0.491184
594 	0.494129
595 	0.497074
596 	0.499723
597 	0.502372
598 	0.505213
599 	0.508055
600 	0.513473
601 	0.516158
602 	0.518842
603 	0.521577
604 	0.524313
605 	0.529824
606 	0.532459
607 	0.535095
608 	0.537907
609 	0.540719
610 	0.543612
611 	0.546504
612 	0.551995
613 	0.554767
614 	0.557539
615 	0.5602
616 	0.56286
617 	0.565335
618 	0.56781
619 	0.573288
620 	0.576271
621 	0.579253
622 	0.582143
623 	0.585033
624 	0.590237
625 	0.592845
626 	0.595452
627 	0.598015
628 	0.600578
629 	0.606012
630 	0.608815
631 	0.611618
632 	0.614538
633 	0.617458
634 	0.620353
635 	0.623248
636 	0.628661
637 	0.631481
638 	0.634301
639 	0.637517
640 	0.640733
641 	0.64535
642 	0.648564
643 	0.651779
644 	0.654132
645 	0.656485
646 	0.662713
647 	0.66582
648 	0.668927
649 	0.671773
650 	0.674619
651 	0.680667
652 	0.683142
653 	0.685618
654 	0.688507
655 	0.691397
656 	0.697026
657 	0.699933
658 	0.702839
659 	0.705795
660 	0.708751
661 	0.713792
662 	0.716167
663 	0.718542
664 	0.721031
665 	0.72352
666 	0.72826
667 	0.731104
668 	0.733947
669 	0.737198
670 	0.740449
671 	0.745571
672 	0.747747
673 	0.749923
674 	0.752307
675 	0.754692
676 	0.759711
677 	0.761787
678 	0.763862
679 	0.766351
680 	0.76884
681 	0.773629
682 	0.775965
683 	0.778301
684 	0.783243
685 	0.785338
686 	0.787432
687 	0.789344
688 	0.791256
689 	0.796196
690 	0.798243
691 	0.800291
692 	0.80249
693 	0.804688
694 	0.808267
695 	0.810252
696 	0.812237
697 	0.81636
698 	0.818353
699 	0.820345
700 	0.822531
701 	0.824717
702 	0.828307
703 	0.830616
704 	0.832925
705 	0.83683
706 	0.838603
707 	0.840375
708 	0.842353
709 	0.84433
710 	0.84799
711 	0.85002
712 	0.85205
713 	0.855378
714 	0.857182
715 	0.858986
716 	0.863116
717 	0.864637
718 	0.866157
719 	0.868015
720 	0.869873
721 	0.873499
722 	0.875636
723 	0.877772
724 	0.881941
725 	0.883727
726 	0.885512
727 	0.890466
728 	0.891853
729 	0.893241
730 	0.895442
731 	0.897642
732 	0.900052
733 	0.901809
734 	0.903566
735 	0.907284
736 	0.909594
737 	0.911903
738 	0.916577
739 	0.918246
740 	0.919914
741 	0.924915
742 	0.92586
743 	0.926804
744 	0.931685
745 	0.933668
746 	0.935651
747 	0.937712
748 	0.939772
749 	0.944126
750 	0.946274
751 	0.948422
752 	0.952346
753 	0.953628
754 	0.954909
755 	0.959068
756 	0.960621
757 	0.962173
758 	0.965253
759 	0.966587
760 	0.967922
761 	0.97155
762 	0.973496
763 	0.975441
764 	0.978756
765 	0.980602
766 	0.982448
767 	0.984255
768 	0.986198
769 	0.988141
770 	0.990326
771 	0.99194
772 	0.993554
773 	0.995108
774 	0.995438
775 	0.995768
776 	0.997825
777 	0.998569
778 	0.999313
779 	1 ];

wavelengths = matrix(:,1);
power = matrix(:,2);