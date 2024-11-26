#' Plot Peptide Positions on a Protein Sequence
#'
#' This function visualizes peptide positions on a protein sequence.
#'
#' @param stroke_positions Data frame of peptide positions for stroke samples.
#' @param control_positions Data frame of peptide positions for control samples.
#' @param protein_length The length of the protein sequence.
#' @param protein_name The name of the protein (default: "Protein").
#' @return A ggplot2 object showing the peptide positions.
#' @export
plot_peptide_positions <- function(stroke_positions, control_positions, protein_length, protein_name = "Protein") {
  library(ggplot2)

  ggplot() +
    # 绘制蛋白条带
    geom_rect(aes(xmin = 1, xmax = protein_length, ymin = 0, ymax = 1),
              fill = "red") +
    annotate("text", x = protein_length / 2, y = 1.2, label = protein_name) +

    # 绘制 stroke 数据（下方，从顶部向下排列）
    geom_rect(data = stroke_positions, aes(xmin = Start, xmax = End, ymin = -Row - 0.5, ymax = -Row + 0.5),
              fill = "darkgreen") +

    # 绘制 control 数据（上方，从顶部向上排列）
    geom_rect(data = control_positions, aes(xmin = Start, xmax = End, ymin = Row + 0.5, ymax = Row + 1.5),
              fill = "darkblue") +

    # 设置图形样式
    theme_minimal() +
    labs(title = paste("Identified Peptides on", protein_name),
         x = "Position on protein",
         y = "") +
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    scale_x_continuous(breaks = seq(0, protein_length, by = 50))
}

