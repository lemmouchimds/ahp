class AHPModel
{
  
  static List<double> vectCN(List<List<double>> matrix)
  {
    List<double> vectC = [];
    for(int i = 0; i < matrix.length; i++)
    {
      double sum = 0;
      for(int j = 0; j < matrix.length; j++)
      {
        sum += matrix[i][j];
      }
      vectC.add(sum);
    }

    double somVectC = 0;
    for(int i = 0; i < vectC.length; i++)
    {
      somVectC += vectC[i];
    }

    List<double> vectCN = [];
    for(int i = 0; i < vectC.length; i++)
    {
      vectCN.add(vectC[i] / somVectC);
    }

    return vectCN;
  }

  static bool isCoherent(List<List<double>> matrix)
  {
    List<double> vectCN = AHPModel.vectCN(matrix);
    List<double> vectD = AHPModel.vectD(matrix);
    List<double> vectE = AHPModel.vectE(vectCN, vectD);
    double somVectE = 0;

    for(int i = 0; i < vectE.length; i++)
    {
      somVectE += vectE[i];
    }


    // double somVectCN = 0;

    Map<int, double> RI = {
      1: 0,
      2: 0,
      3: 0.58,
      4: 0.90,
      5: 1.12,
      6: 1.24,
      7: 1.32,
      8: 1.41,
      9: 1.45,
      10: 1.49,
    };

    double lambdaMax = somVectE / vectCN.length;
    double CI = (lambdaMax - vectCN.length) / (vectCN.length - 1);
    double? RIval = RI[vectCN.length];
    double CR = CI / RIval!;

    if(CR < 0.1)
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  static List<double> vectD(List<List<double>> matrix)
  {
    List<double> vectCN = AHPModel.vectCN(matrix);

    List<double> vectD = [];

    for (var i = 0; i < vectCN.length; i++) {
      double som = 0;
      for (var j = 0; j < matrix[i].length; j++) {
        som += matrix[i][j] * vectCN[j];
      }

      vectD.add(som);
    }

    return vectD;
  }

  static List<double> vectE(List<double> vectCN, List<double> vectD)
  {
    List<double> vectE = [];

    for (var i = 0; i < vectCN.length; i++) {
      vectE.add(vectD[i] / vectCN[i]);
    }

    return vectE;
  }

  static int bestChoice(List<List<double>> matrixCN, List<double> vectCN)
  {
    List<double> results = [];

    for (var i = 0; i < matrixCN.length; i++) {
      double som = 0;
      for (var j = 0; j < matrixCN[i].length; j++) {
        som += matrixCN[i][j] * vectCN[j];
      }

      results.add(som);
    }

    double max = results[0];
    int index = 0;
    for (var i = 0; i < results.length; i++) {
      if(results[i] > max)
      {
        max = results[i];
        index = i;
      }
    }

    return index;

  }

}