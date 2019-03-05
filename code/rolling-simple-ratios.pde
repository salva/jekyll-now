
int min_radius = 55;
int margin = 5;

float min_relation = 0.05;
float max_relation = 0.95;

int cols, rows, frames, radius;

int t = 0;
int n_dots = 1;
int dot_radius = 2;

void setup() {
  size(1800, 920);
  background(100);

  int min_box = margin + 2 * min_radius;
  cols = int((1800 - margin) / min_box);
  rows = int((920 - margin) / min_box);
  frames = rows * cols;

  radius = int(0.5 * (min((1800 - margin) / cols,
                          (920 - margin) / rows) - margin));
  //println("setup done");
}

void draw_step(int offx, int offy, float relation, float alfa, int clr) {
  float inner_radius = radius * relation;

  float beta = -alfa / relation;

  float x0 = offx + radius + (radius - inner_radius) * sin(alfa);
  float y0 = offy + radius + (radius - inner_radius) * cos(alfa);

  for (int i = 0; i < n_dots; i++) {
    float gamma = i * 2 * PI / n_dots;

    float x1 = x0 + inner_radius * sin(alfa + beta + gamma);
    float y1 = y0 + inner_radius * cos(alfa + beta + gamma);

    ellipse(x1 - dot_radius, y1 - dot_radius, 2 * dot_radius, 2 * dot_radius);
  }
}

void draw() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int frame = j * cols + i;
      float relation = min_relation + (max_relation - min_relation) * frame / (frames - 1);
      float rounded_relation = int(relation * 120 + 0.5) / 120;
      float alfa = 2 * PI * t / 360;
      draw_step(margin + i * (margin + 2 * radius),
                margin + j * (margin + 2 * radius),
                rounded_relation, alfa, 1);
    }
  }
  t = t + 1;
  if (t >= 360000) {
    t = 0;
  }
}
