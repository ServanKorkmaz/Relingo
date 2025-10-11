export const religionColors: Record<string, string> = {
  islam: "#0EA5E9",
  christianity: "#8B5CF6",
  hinduism: "#F59E0B",
  buddhism: "#EC4899",
  judaism: "#14B8A6",
  sikhism: "#22C55E",
};

export function getReligionColor(slug: string): string {
  return religionColors[slug] || "#2ED573";
}
