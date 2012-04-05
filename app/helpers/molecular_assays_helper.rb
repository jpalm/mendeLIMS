module MolecularAssaysHelper
  def sample_vol(molecular_assay)
    if molecular_assay.vol_from_source
      return number_with_precision(molecular_assay.vol_from_source, :precision => 2)
    else
      return ' '
    end
  end
  
  def buffer_vol(molecular_assay)
    if molecular_assay.vol_from_source && molecular_assay.volume
      return number_with_precision(molecular_assay.volume - molecular_assay.vol_from_source, :precision => 2)
    else
      return ' '
    end
  end
end