const input = 368078;

let map;

function main(insert, stop, ret) {
    return function(num) {
        let x = 0, y = 0;
        let counter = 1;
        let side = 1;

        map = { "0": { "0": 1 } };

        function goDirection(dirX, dirY, len) {
            for(let i = 0; i < len; i++) {
                x += dirX;
                y += dirY;

                counter = insert(counter, x, y);

                if(!map[x]) {
                    map[x] = { [y]: counter }
                } else {
                    map[x][y] = counter;
                }

                if(stop(counter, num)) {
                    throw [x,y,counter];
                }
            }
        }

        try {
            while(true) {
                side += 2;
                goDirection(+1, 0, 1);
                goDirection(0, +1, side - 2);
                goDirection(-1, 0, side - 1);
                goDirection(0, -1, side - 1);
                goDirection(+1, 0, side - 1);
            }
        } catch (e) {
            return ret(e);
        }
    }
}

function getNeighbors(n, x, y) {
    let sum = 0;
    for(let i = -1; i <= 1; i++) {
        for(let j = -1; j <= 1; j++) {
            if(i === 0 && j === 0) {
                continue;
            }
            if(map[x + i] && map[x + i][y + j]) {
                sum += map[x + i][y + j];
            }
        }
    }
    return sum;
}

const part1 = main(
    (n, x, y) => n + 1,
    (n, num) => n === num,
    ([x, y, _]) => Math.abs(x) + Math.abs(y)
);

const part2 = main(
    getNeighbors,
    (n, num) => n > num,
    ([x, y, n]) => n
);

console.log("Part 1: Result is " + part1(input));
console.log("Part 2: Result is " + part2(input));
