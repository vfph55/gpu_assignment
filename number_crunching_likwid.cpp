#include <iostream>
#include <likwid.h>

double function_a(const double *u, const double *v, const int N) {
  double s = 0;
  for (unsigned int i = 0; i < N; i++) {
    s += u[i] * v[i];
  }
  return s;
}

double *function_b(const double *u, const double *v, const int N) {
  double *x = new double[N];
  for (unsigned int i = 0; i < N; i++) {
    x[i] = u[i] + v[i];
  }
  return x;
}

double *function_c(const double *A, const double *x, const int N) {
  double *y = new double[N];
  for (unsigned int i = 0; i < N; i++) {
    y[i] = 0;
  }
  LIKWID_MARKER_START("function_c");
  for (unsigned int i = 0; i < N; i++) {
    for (unsigned int j = 0; j < N; j++) {
      y[i] += A[i * N + j] * x[i];
    }
  }
  LIKWID_MARKER_STOP("function_c"); 
  return y;
}

double *function_d(const double s, const double *x, const double *y,
                   const int N) {
  double *z = new double[N];
  for (unsigned int i = 0; i < N; i++) {
    if (i % 2 == 0) {
      z[i] = s * x[i] + y[i];
    } else {
      z[i] = x[i] + y[i];
    }
  }
  return z;
}

void init_datastructures(double *u, double *v, double *A, const int N) {
  for (unsigned int i = 0; i < N; i++) {
    u[i] = 1;
    v[i] = 1;
  }

  for (unsigned int i = 0; i < N * N; i++) {
    A[i] = 1;
  }
}

void print_results(const double s, const double *x, const double *y,
                   const double *z, const double *A, const int N) {
  std::cout << "s: " << std::endl << s << std::endl;

  std::cout << "x: " << std::endl;
  for (unsigned int i = 0; i < N; i++) {
    std::cout << x[i] << " ";
  }
  std::cout << std::endl;

  std::cout << "y: " << std::endl;
  for (unsigned int i = 0; i < N; i++) {
    std::cout << y[i] << " ";
  }
  std::cout << std::endl;

  std::cout << "z: " << std::endl;
  for (unsigned int i = 0; i < N; i++) {
    std::cout << z[i] << " ";
  }
  std::cout << std::endl;

  std::cout << "A: " << std::endl;
  for (unsigned int i = 0; i < N * N; i++) {
    std::cout << A[i] << " ";
  }
  std::cout << std::endl;
}

int main(int argc, char **argv) {
  int N;

  if (argc == 2) {
    N = std::stoi(argv[1]);
  } else {
    std::cout << "Error: Missing problem size N. Please provide N as "
                 "commandline parameter."
              << std::endl;
    exit(0);
  }
  LIKWID_MARKER_INIT;
  double *u = new double[N];
  double *v = new double[N];
  double *A = new double[N * N];

  init_datastructures(u, v, A, N);

  double s = function_a(u, v, N);
  double *x = function_b(u, v, N);
  double *y = function_c(A, x, N);
  double *z = function_d(s, x, y, N);

  print_results(s, x, y, z, A, N);

  delete[] u;
  delete[] v;
  delete[] A;
  delete[] x;
  delete[] y;
  delete[] z;
  
  LIKWID_MARKER_CLOSE;
  EXIT_SUCCESS;
}
