const { GPU } = require('gpu.js');
const gpu = new GPU();
const size = 5000;
const multiplyMatrix = gpu.createKernel(function(a, b) {
    let sum = 0;
    for (let i = 0; i < 5000; i++) {
        sum += a[this.thread.y][i] * b[i][this.thread.x];
    }
    return sum;
}).setOutput([size, size]);

// 计算下面三段，大概可以让gtx1050ti满载20s左右

const x1 = [1,2,3];
const x2 = [4,5,6];
// console.time('x')
multiplyMatrix(x1, x2);
// console.timeEnd('x')

const x3 = [7,8,9];
const x4 = [10,11,12];
// console.time('x')
multiplyMatrix(x3, x4);
// console.timeEnd('x')

const x5 = [13,14,15];
const x6 = [16,17,18];
// console.time('x')
multiplyMatrix(x5, x6);
// console.timeEnd('x')