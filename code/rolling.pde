
int min_radius = 70;
int margin = 20;

float min_relation = 0.05;
float max_relation = 0.95;

int cols, rows, frames, radius;

int t = 0;
int n_dots = 7;
int dot_radius = 2;

void setup() {
  size(1200, 850);
  background(100);

  int min_box = margin + 2 * min_radius;
  cols = int((1200 - margin) / min_box);
  rows = int((850 - margin) / min_box);
  frames = rows * cols;

  radius = int(0.5 * (min((1200 - margin) / cols,
                          (850 - margin) / rows) - margin));
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
      float alfa = 2 * PI * t / 360;
      draw_step(margin + i * (margin + 2 * radius),
                margin + j * (margin + 2 * radius),
                relation, alfa, 1);
    }
  }
  t = t + 1;
  if (t >= 360000) {
    t = 0;
  }
}
