__attribute__((noinline)) int add(int a, int b) { return a + b; }
__attribute__((noinline)) int sum(int n) {
    int s = 0;
    for (int i = 1; i <= n; i++) s = add(s, i);
    return s;
}
int main(void) { return sum(5); }
