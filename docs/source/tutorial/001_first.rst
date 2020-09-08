.. only:: html

    .. note::
        :class: sphx-glr-download-link-note

        Click :ref:`here <sphx_glr_download_tutorial_001_first.py>`     to download the full example code
    .. rst-class:: sphx-glr-example-title

    .. _sphx_glr_tutorial_001_first.py:


.. _first:

First Optimization
==================

Quadratic Function Example
--------------------------

Usually, Optuna is used to optimize hyper-parameters, but as an example,
let us directly optimize a quadratic function in an IPython shell.


.. code-block:: default



    import optuna








The objective function is what will be optimized.


.. code-block:: default



    def objective(trial):
        x = trial.suggest_uniform('x', -10, 10)
        return (x - 2) ** 2









This function returns the value of :math:`(x - 2)^2`. Our goal is to find the value of ``x``
that minimizes the output of the ``objective`` function. This is the "optimization."
During the optimization, Optuna repeatedly calls and evaluates the objective function with
different values of ``x``.

A :class:`~optuna.trial.Trial` object corresponds to a single execution of the objective
function and is internally instantiated upon each invocation of the function.

The `suggest` APIs (for example, :func:`~optuna.trial.Trial.suggest_float`) are called
inside the objective function to obtain parameters for a trial.
:func:`~optuna.trial.Trial.suggest_float` selects parameters uniformly within the range
provided. In our example, from :math:`-10` to :math:`10`.

To start the optimization, we create a study object and pass the objective function to method
:func:`~optuna.study.Study.optimize` as follows.


.. code-block:: default


    study = optuna.create_study()
    study.optimize(objective, n_trials=100)









You can get the best parameter as follows.


.. code-block:: default


    print(study.best_params)





.. rst-class:: sphx-glr-script-out

 Out:

 .. code-block:: none

    {'x': 2.013245582041326}




We can see that the ``x`` value found by Optuna is close to the optimal value of ``2``.

.. note::
    When used to search for hyper-parameters in machine learning,
    usually the objective function would return the loss or accuracy
    of the model.

Study Object
------------

Let us clarify the terminology in Optuna as follows:

* **Trial**: A single call of the objective function
* **Study**: An optimization session, which is a set of trials
* **Parameter**: A variable whose value is to be optimized, such as ``x`` in the above example

In Optuna, we use the study object to manage optimization.
Method :func:`~optuna.study.create_study` returns a study object.
A study object has useful properties for analyzing the optimization outcome.

To get the best parameter:


.. code-block:: default



    study.best_params





.. rst-class:: sphx-glr-script-out

 Out:

 .. code-block:: none


    {'x': 2.013245582041326}



To get the best value:


.. code-block:: default


    study.best_value






.. rst-class:: sphx-glr-script-out

 Out:

 .. code-block:: none


    0.0001754454436135031



To get the best trial:


.. code-block:: default


    study.best_trial






.. rst-class:: sphx-glr-script-out

 Out:

 .. code-block:: none


    FrozenTrial(number=66, value=0.0001754454436135031, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 839713), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 842239), params={'x': 2.013245582041326}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=66, state=TrialState.COMPLETE)



To get all trials:


.. code-block:: default


    study.trials






.. rst-class:: sphx-glr-script-out

 Out:

 .. code-block:: none


    [FrozenTrial(number=0, value=109.95661067538214, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 665532), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 665731), params={'x': -8.486019772791874}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=0, state=TrialState.COMPLETE), FrozenTrial(number=1, value=29.62338103007538, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 666023), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 666129), params={'x': -3.4427365387344793}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=1, state=TrialState.COMPLETE), FrozenTrial(number=2, value=17.45669829678056, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 666374), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 666473), params={'x': -2.1781213836819724}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=2, state=TrialState.COMPLETE), FrozenTrial(number=3, value=30.679000164576465, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 666720), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 666820), params={'x': -3.5388627140033417}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=3, state=TrialState.COMPLETE), FrozenTrial(number=4, value=109.4860546166325, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 667062), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 667163), params={'x': -8.463558410819548}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=4, state=TrialState.COMPLETE), FrozenTrial(number=5, value=63.696170062740364, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 667403), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 667506), params={'x': 9.980988038002586}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=5, state=TrialState.COMPLETE), FrozenTrial(number=6, value=2.905924279174548, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 667739), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 667843), params={'x': 0.29532282259233966}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=6, state=TrialState.COMPLETE), FrozenTrial(number=7, value=0.6249539568602944, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 668079), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 668184), params={'x': 1.2094597057326588}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=7, state=TrialState.COMPLETE), FrozenTrial(number=8, value=98.65951347111869, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 668421), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 668543), params={'x': -7.93274954235325}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=8, state=TrialState.COMPLETE), FrozenTrial(number=9, value=4.438449040409877, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 668777), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 668882), params={'x': 4.106762692001611}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=9, state=TrialState.COMPLETE), FrozenTrial(number=10, value=14.945732575249767, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 669111), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 672405), params={'x': 5.865971103778424}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=10, state=TrialState.COMPLETE), FrozenTrial(number=11, value=0.01011388250547813, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 672676), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 675641), params={'x': 1.8994321994598762}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=11, state=TrialState.COMPLETE), FrozenTrial(number=12, value=0.04459210090994003, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 675908), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 678854), params={'x': 2.2111684183535503}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=12, state=TrialState.COMPLETE), FrozenTrial(number=13, value=6.856607274030848, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 679124), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 682085), params={'x': 4.618512416245309}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=13, state=TrialState.COMPLETE), FrozenTrial(number=14, value=23.918174755796876, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 682343), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 685386), params={'x': 6.890621101230075}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=14, state=TrialState.COMPLETE), FrozenTrial(number=15, value=0.3431664003798297, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 685664), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 688863), params={'x': 2.5858040631301815}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=15, state=TrialState.COMPLETE), FrozenTrial(number=16, value=48.191375591789686, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 689116), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 692046), params={'x': 8.942000834902693}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=16, state=TrialState.COMPLETE), FrozenTrial(number=17, value=12.634245580507226, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 692292), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 695109), params={'x': -1.554468396329784}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=17, state=TrialState.COMPLETE), FrozenTrial(number=18, value=0.047703228086693715, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 700203), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 703216), params={'x': 2.2184106867501994}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=18, state=TrialState.COMPLETE), FrozenTrial(number=19, value=57.10824291551879, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 703477), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 705971), params={'x': -5.55699959742746}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=19, state=TrialState.COMPLETE), FrozenTrial(number=20, value=32.87517235699601, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 706198), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 708663), params={'x': 7.733687500814463}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=20, state=TrialState.COMPLETE), FrozenTrial(number=21, value=0.023792253649278606, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 708881), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 711370), params={'x': 2.1542473780953135}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=21, state=TrialState.COMPLETE), FrozenTrial(number=22, value=2.303443513128221, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 711601), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 714040), params={'x': 3.5177099568521717}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=22, state=TrialState.COMPLETE), FrozenTrial(number=23, value=4.713973091490649, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 714251), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 716659), params={'x': -0.17116860042942061}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=23, state=TrialState.COMPLETE), FrozenTrial(number=24, value=0.7571276432223343, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 716871), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 719270), params={'x': 1.129869180397376}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=24, state=TrialState.COMPLETE), FrozenTrial(number=25, value=12.30486399890363, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 719479), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 721914), params={'x': 5.50782895804565}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=25, state=TrialState.COMPLETE), FrozenTrial(number=26, value=0.4068977286324476, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 722138), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 724584), params={'x': 2.637885356966632}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=26, state=TrialState.COMPLETE), FrozenTrial(number=27, value=2.812548065803585, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 727349), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 729972), params={'x': 0.3229346864824898}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=27, state=TrialState.COMPLETE), FrozenTrial(number=28, value=11.50361403576936, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 730228), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 732769), params={'x': -1.3916978102079436}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=28, state=TrialState.COMPLETE), FrozenTrial(number=29, value=2.9057593749390174, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 732999), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 735565), params={'x': 3.7046288085501247}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=29, state=TrialState.COMPLETE), FrozenTrial(number=30, value=9.153477183069082, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 735788), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 738311), params={'x': 5.025471398488024}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=30, state=TrialState.COMPLETE), FrozenTrial(number=31, value=0.0711841681944609, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 738534), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 741131), params={'x': 2.2668036135333645}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=31, state=TrialState.COMPLETE), FrozenTrial(number=32, value=0.16742880943163613, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 741349), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 743881), params={'x': 1.5908193437714386}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=32, state=TrialState.COMPLETE), FrozenTrial(number=33, value=7.054790367019403, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 744102), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 746638), params={'x': -0.6560855345826879}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=33, state=TrialState.COMPLETE), FrozenTrial(number=34, value=23.884562205403288, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 746856), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 749275), params={'x': -2.8871834634483786}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=34, state=TrialState.COMPLETE), FrozenTrial(number=35, value=1.273034259205387, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 749492), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 751920), params={'x': 3.1282881986466875}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=35, state=TrialState.COMPLETE), FrozenTrial(number=36, value=38.07186325122411, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 752116), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 754406), params={'x': -4.170240129137934}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=36, state=TrialState.COMPLETE), FrozenTrial(number=37, value=0.505147550826103, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 754598), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 756813), params={'x': 1.2892626710055937}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=37, state=TrialState.COMPLETE), FrozenTrial(number=38, value=17.009061736433132, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 757003), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 759794), params={'x': 6.124204376171619}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=38, state=TrialState.COMPLETE), FrozenTrial(number=39, value=0.017648028090778044, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 760625), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 763552), params={'x': 2.132845880970311}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=39, state=TrialState.COMPLETE), FrozenTrial(number=40, value=1.7539446684777313, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 763761), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 765994), params={'x': 0.675634239162862}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=40, state=TrialState.COMPLETE), FrozenTrial(number=41, value=0.03616983340874352, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 766187), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 768569), params={'x': 2.190183683339932}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=41, state=TrialState.COMPLETE), FrozenTrial(number=42, value=7.528078435441499, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 768767), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 771007), params={'x': -0.7437343959358564}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=42, state=TrialState.COMPLETE), FrozenTrial(number=43, value=5.991270614745434, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 771203), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 773876), params={'x': 4.447707215895201}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=43, state=TrialState.COMPLETE), FrozenTrial(number=44, value=0.0021523281284262633, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 774075), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 776329), params={'x': 2.046393190539413}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=44, state=TrialState.COMPLETE), FrozenTrial(number=45, value=1.9969373733545794, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 776532), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 778827), params={'x': 3.4131303454935003}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=45, state=TrialState.COMPLETE), FrozenTrial(number=46, value=1.178862248011076, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 779024), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 781263), params={'x': 0.9142457699778113}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=46, state=TrialState.COMPLETE), FrozenTrial(number=47, value=0.04608097139876375, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 781447), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 783645), params={'x': 1.7853352115535392}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=47, state=TrialState.COMPLETE), FrozenTrial(number=48, value=3.4512142863559023, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 783827), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 785997), params={'x': 0.14225559175760072}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=48, state=TrialState.COMPLETE), FrozenTrial(number=49, value=17.311258688407456, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 786181), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 788522), params={'x': -2.1606800752289828}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=49, state=TrialState.COMPLETE), FrozenTrial(number=50, value=4.42077249970431, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 788708), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 791537), params={'x': 4.10256331645549}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=50, state=TrialState.COMPLETE), FrozenTrial(number=51, value=0.2598918698692674, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 792078), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 796213), params={'x': 2.5097959100162215}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=51, state=TrialState.COMPLETE), FrozenTrial(number=52, value=0.005593953123889492, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 796475), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 799100), params={'x': 1.9252072655675065}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=52, state=TrialState.COMPLETE), FrozenTrial(number=53, value=1.4028467998931242, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 799297), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 801482), params={'x': 3.184418338212105}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=53, state=TrialState.COMPLETE), FrozenTrial(number=54, value=0.006635530379554072, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 801668), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 804118), params={'x': 1.9185412350968045}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=54, state=TrialState.COMPLETE), FrozenTrial(number=55, value=7.125648490335486, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 804319), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 807312), params={'x': -0.6693910336133757}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=55, state=TrialState.COMPLETE), FrozenTrial(number=56, value=0.18380262844699277, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 807522), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 810258), params={'x': 1.5712779123406484}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=56, state=TrialState.COMPLETE), FrozenTrial(number=57, value=8.514639824094719, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 811272), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 814186), params={'x': 4.917985576402789}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=57, state=TrialState.COMPLETE), FrozenTrial(number=58, value=1.6721357153492555, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 814410), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 817895), params={'x': 0.7068891326149735}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=58, state=TrialState.COMPLETE), FrozenTrial(number=59, value=18.698646883274062, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 818176), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 820880), params={'x': 6.3241932060529}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=59, state=TrialState.COMPLETE), FrozenTrial(number=60, value=0.5502971915529323, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 821165), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 824862), params={'x': 2.741820188154065}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=60, state=TrialState.COMPLETE), FrozenTrial(number=61, value=0.007401007689143372, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 825144), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 827810), params={'x': 1.9139708904547805}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=61, state=TrialState.COMPLETE), FrozenTrial(number=62, value=3.9161788211612625, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 828092), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 830947), params={'x': 3.978933758659259}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=62, state=TrialState.COMPLETE), FrozenTrial(number=63, value=4.731013128037798, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 831207), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 833848), params={'x': -0.1750892230062191}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=63, state=TrialState.COMPLETE), FrozenTrial(number=64, value=0.15669498689824274, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 834078), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 836705), params={'x': 1.6041528238091842}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=64, state=TrialState.COMPLETE), FrozenTrial(number=65, value=0.8257305127432899, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 836931), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 839500), params={'x': 2.908697151279396}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=65, state=TrialState.COMPLETE), FrozenTrial(number=66, value=0.0001754454436135031, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 839713), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 842239), params={'x': 2.013245582041326}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=66, state=TrialState.COMPLETE), FrozenTrial(number=67, value=11.71797426162205, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 845444), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 848939), params={'x': -1.423152678689931}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=67, state=TrialState.COMPLETE), FrozenTrial(number=68, value=134.9983986139208, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 849297), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 852486), params={'x': -9.61888112573327}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=68, state=TrialState.COMPLETE), FrozenTrial(number=69, value=0.008871034948689004, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 852779), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 855726), params={'x': 1.905813828251229}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=69, state=TrialState.COMPLETE), FrozenTrial(number=70, value=1.9627514815846525, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 856137), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 859110), params={'x': 0.5990176726365701}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=70, state=TrialState.COMPLETE), FrozenTrial(number=71, value=0.746151404937232, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 859339), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 861983), params={'x': 1.1361994414581384}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=71, state=TrialState.COMPLETE), FrozenTrial(number=72, value=0.011712572185332186, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 862224), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 864868), params={'x': 2.1082246376077656}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=72, state=TrialState.COMPLETE), FrozenTrial(number=73, value=1.699773013822782, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 865084), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 867585), params={'x': 3.303753432909299}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=73, state=TrialState.COMPLETE), FrozenTrial(number=74, value=4.371037008130115, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 867785), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 870257), params={'x': -0.0907025154550598}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=74, state=TrialState.COMPLETE), FrozenTrial(number=75, value=0.02958109189975566, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 870480), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 874418), params={'x': 1.8280084539875414}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=75, state=TrialState.COMPLETE), FrozenTrial(number=76, value=2.727210409065138, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 874889), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 878109), params={'x': 3.65142677980743}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=76, state=TrialState.COMPLETE), FrozenTrial(number=77, value=0.6482727382800081, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 878474), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 881063), params={'x': 1.1948461399955856}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=77, state=TrialState.COMPLETE), FrozenTrial(number=78, value=0.3854692783498753, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 881285), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 883749), params={'x': 2.620861722406749}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=78, state=TrialState.COMPLETE), FrozenTrial(number=79, value=5.54393173236083, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 883954), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 886222), params={'x': 4.354555527559465}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=79, state=TrialState.COMPLETE), FrozenTrial(number=80, value=0.00027035420958934983, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 886422), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 889109), params={'x': 1.983557548552927}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=80, state=TrialState.COMPLETE), FrozenTrial(number=81, value=0.008926799396520139, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 889351), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 891998), params={'x': 2.0944817410747714}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=81, state=TrialState.COMPLETE), FrozenTrial(number=82, value=2.4662764167638582, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 892200), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 894578), params={'x': 0.42956171188936626}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=82, state=TrialState.COMPLETE), FrozenTrial(number=83, value=0.7887952735401585, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 894804), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 897348), params={'x': 2.888141471579927}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=83, state=TrialState.COMPLETE), FrozenTrial(number=84, value=0.3644067228436645, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 897575), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 899929), params={'x': 1.3963389006705298}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=84, state=TrialState.COMPLETE), FrozenTrial(number=85, value=0.005850224748949635, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 900126), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 902410), params={'x': 1.9235132380803734}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=85, state=TrialState.COMPLETE), FrozenTrial(number=86, value=10.916287093896825, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 902611), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 904911), params={'x': 5.303980492360211}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=86, state=TrialState.COMPLETE), FrozenTrial(number=87, value=0.0008772994268469132, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 905114), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 908346), params={'x': 1.9703807591784173}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=87, state=TrialState.COMPLETE), FrozenTrial(number=88, value=1.1737580340325802, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 908657), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 911131), params={'x': 0.9165988582096749}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=88, state=TrialState.COMPLETE), FrozenTrial(number=89, value=2.925697358687341, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 911344), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 913708), params={'x': 3.710467000174906}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=89, state=TrialState.COMPLETE), FrozenTrial(number=90, value=5.451772281501425, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 913912), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 916189), params={'x': -0.3349030561249058}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=90, state=TrialState.COMPLETE), FrozenTrial(number=91, value=0.1178192972946286, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 916387), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 918685), params={'x': 2.343248157015633}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=91, state=TrialState.COMPLETE), FrozenTrial(number=92, value=0.0039024355138049306, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 918883), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 921283), params={'x': 1.9375305233429563}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=92, state=TrialState.COMPLETE), FrozenTrial(number=93, value=0.15433603292145945, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 921490), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 923860), params={'x': 1.6071437503087682}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=93, state=TrialState.COMPLETE), FrozenTrial(number=94, value=3.1596403456943793, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 924979), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 927588), params={'x': 0.22246228009238034}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=94, state=TrialState.COMPLETE), FrozenTrial(number=95, value=1.116964502894508, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 927819), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 930201), params={'x': 3.05686541380372}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=95, state=TrialState.COMPLETE), FrozenTrial(number=96, value=0.34667691562339636, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 930409), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 932702), params={'x': 2.5887927611846093}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=96, state=TrialState.COMPLETE), FrozenTrial(number=97, value=1.1818864488215493, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 932900), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 935211), params={'x': 0.9128539891893319}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=97, state=TrialState.COMPLETE), FrozenTrial(number=98, value=8.903181672551671, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 935413), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 937785), params={'x': -0.983819979916964}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=98, state=TrialState.COMPLETE), FrozenTrial(number=99, value=0.012362593439232144, datetime_start=datetime.datetime(2020, 9, 3, 11, 40, 52, 937988), datetime_complete=datetime.datetime(2020, 9, 3, 11, 40, 52, 940679), params={'x': 1.8888128000207212}, distributions={'x': UniformDistribution(high=10, low=-10)}, user_attrs={}, system_attrs={}, intermediate_values={}, trial_id=99, state=TrialState.COMPLETE)]



To get the number of trials:


.. code-block:: default


    len(study.trials)






.. rst-class:: sphx-glr-script-out

 Out:

 .. code-block:: none


    100



By executing :func:`~optuna.study.Study.optimize` again, we can continue the optimization.


.. code-block:: default


    study.optimize(objective, n_trials=100)









To get the updated number of trials:


.. code-block:: default


    len(study.trials)




.. rst-class:: sphx-glr-script-out

 Out:

 .. code-block:: none


    200




.. rst-class:: sphx-glr-timing

   **Total running time of the script:** ( 0 minutes  0.603 seconds)


.. _sphx_glr_download_tutorial_001_first.py:


.. only :: html

 .. container:: sphx-glr-footer
    :class: sphx-glr-footer-example



  .. container:: sphx-glr-download sphx-glr-download-python

     :download:`Download Python source code: 001_first.py <001_first.py>`



  .. container:: sphx-glr-download sphx-glr-download-jupyter

     :download:`Download Jupyter notebook: 001_first.ipynb <001_first.ipynb>`


.. only:: html

 .. rst-class:: sphx-glr-signature

    `Gallery generated by Sphinx-Gallery <https://sphinx-gallery.github.io>`_
