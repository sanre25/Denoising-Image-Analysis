
# Files Description 
I suggest that please read the research paper first to understand the implementation. In the research paper they have 2 main algorithms and  I follow the same naming convention as per algorithms.

- According to the paper, algo 1 is *Smoothed and Reweighted Low-Rank Matrix Recovery (SRLRMR)*, that implementation can be found in **algo1_SRLRMR.m** file. Under that function file -

    -  Input : Data matrix $M$.
    -  Initilaise W_X, W_E, eps, k, maxiter
    -  calculate $X^(0)$ and $E^(0)$ using IALM (reference 39, according to the paper) **inexact_alm_rpca.m** func file, and supporting file for runninf that func can be found in **PROPACK** folder ( Ensure you have it your working directory), also **choosvd.m** file is require.
    - next is **obj_func.m** file, which trace the objectuve function value(from paper). Supporting file for that  **TV_norm.m**
    - Enter in **while()** loop-
       - In this while loop we call ***algo2()***  func file. which is implementation of  *IALM Algorithm for Solving the Problem of Smoothed and Reweighted Low-Rank Matrix Recovery* (Algo2 from paper)

       # algo2.m file

       - In **algo2()** func, after all initialisation we enter to the *while* loop.
       - In *while* loop -
         - Step : 1 - (see paper algo 2 for reference) I call **NSVT.m**  for applyinh NSVT operator.
         - Step : 2 - Call **FGP** algorithm, (I have implemented it separately also). **FGP_fun.m** is the main func file. Supporting files for that
             - **L_tr_fun.m**
             - **proj_C.m**
             - **L_fun.m**
             - **projection_pq_pho.m**
         - Step :3 - Call **NST.m** operator.
        
