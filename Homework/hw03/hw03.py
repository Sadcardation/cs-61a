HW_SOURCE_FILE = __file__


def num_eights(pos):
    """Returns the number of times 8 appears as a digit of pos.

    >>> num_eights(3)
    0
    >>> num_eights(8)
    1
    >>> num_eights(88888888)
    8
    >>> num_eights(2638)
    1
    >>> num_eights(86380)
    2
    >>> num_eights(12345)
    0
    >>> num_eights(8782089)
    3
    >>> from construct_check import check
    >>> # ban all assignment statements
    >>> check(HW_SOURCE_FILE, 'num_eights',
    ...       ['Assign', 'AnnAssign', 'AugAssign', 'NamedExpr', 'For', 'While'])
    True
    """
    if pos < 10:
        return (pos == 8) + 0
    else:
        return num_eights(pos // 10) + (pos % 10 == 8)


def pingpong(n):
    """Return the nth element of the ping-pong sequence.

    >>> pingpong(8)
    8
    >>> pingpong(10)
    6
    >>> pingpong(15)
    1
    >>> pingpong(21)
    -1
    >>> pingpong(22)
    -2
    >>> pingpong(30)
    -2
    >>> pingpong(68)
    0
    >>> pingpong(69)
    -1
    >>> pingpong(80)
    0
    >>> pingpong(81)
    1
    >>> pingpong(82)
    0
    >>> pingpong(100)
    -6
    >>> from construct_check import check
    >>> # ban assignment statements
    >>> check(HW_SOURCE_FILE, 'pingpong',
    ...       ['Assign', 'AnnAssign', 'AugAssign', 'NamedExpr'])
    True
    """
    if n == 1:
        return 1
    else:
        return pingpong(n - 1) + direction(n - 1) * 1


def direction(n):
    if n == 1:
        return 1
    elif num_eights(n) > 0 or n % 8 == 0:
        return -1 * direction(n - 1)
    else:
        return 1 * direction(n - 1)


def next_larger_coin(coin):
    """Returns the next larger coin in order.
    >>> next_larger_coin(1)
    5
    >>> next_larger_coin(5)
    10
    >>> next_larger_coin(10)
    25
    >>> next_larger_coin(2) # Other values return None
    """
    if coin == 1:
        return 5
    elif coin == 5:
        return 10
    elif coin == 10:
        return 25


def next_smaller_coin(coin):
    """Returns the next smaller coin in order.
    >>> next_smaller_coin(25)
    10
    >>> next_smaller_coin(10)
    5
    >>> next_smaller_coin(5)
    1
    >>> next_smaller_coin(2) # Other values return None
    """
    if coin == 25:
        return 10
    elif coin == 10:
        return 5
    elif coin == 5:
        return 1


def count_coins(change):
    """Return the number of ways to make change using coins of value of 1, 5, 10, 25.
    >>> count_coins(15)
    6
    >>> count_coins(10)
    4
    >>> count_coins(20)
    9
    >>> count_coins(100) # How many ways to make change for a dollar?
    242
    >>> count_coins(200)
    1463
    >>> from construct_check import check
    >>> # ban iteration
    >>> check(HW_SOURCE_FILE, 'count_coins', ['While', 'For'])
    True
    """
    # return counter(change, 25)
    #
    # I wrote this shit using another function called counter() to trace the max available
    # coin in a specific choosing round and I cannot understand the mystery of two functions
    # offered above.
    #
    # This implementation choose different coins each time as different part, and each child-choice
    # cannot choose a coin larger than its parent-choice.
    #
    # I refer the implementation of count_partitions() and find that count_coins()
    # is difficult to do recursion by itself when max available coin is unknown for one-parameter
    # function count_coins() since repetition can easily occur:
    # change = 6, coins = 1, 5
    # change = 6, coins = 5, 1
    # These should be counted as one possible type of combination but they would be considered as
    # two different types in my original implementation if max_coin cannot be traced.
    # But it can just work.

    # The idea of count_helper separate the parent problem according to whether to use the max_coin
    # at present, two sub set is mutually exclusive and complement each other, without worrying
    # repetition. This is a better way referring the count_partitions().
    def count_helper(change, max_coin):
        if change < 0:
            return 0
        elif change == 0:
            return 1
        else:
            with_coin = count_helper(change - max_coin, max_coin)
            without_coin = 0
            if next_smaller_coin(max_coin):
                without_coin = count_helper(change, next_smaller_coin(max_coin))
            return with_coin + without_coin

    return count_helper(change, 25)


# def counter(change, max_coin):
#     if change < 0:
#         return 0
#     elif change < 1:
#         return 1
#     else:
#         if max_coin == 25:
#             try25 = counter(change - 25, 25)
#             try10 = counter(change - 10, 10)
#             try05 = counter(change - 5, 5)
#             try01 = counter(change - 1, 1)
#             return try25 + try10 + try05 + try01
#         if max_coin == 10:
#             try10 = counter(change - 10, 10)
#             try05 = counter(change - 5, 5)
#             try01 = counter(change - 1, 1)
#             return try10 + try05 + try01
#         if max_coin == 5:
#             try05 = counter(change - 5, 5)
#             try01 = counter(change - 1, 1)
#             return try05 + try01
#         if max_coin == 1:
#             try01 = counter(change - 1, 1)
#             return try01


anonymous = False  # Change to True if you would like to remain anonymous on the final leaderboard.


def beaver(f):
    "*** YOUR CODE HERE ***"
    (lambda g: g(g(g(g(g(g(f)))))))(lambda f: lambda: f() or f() or f() or f())()


def beaver_syntax_check():
    """
    Checks that definition of beaver is only one line.

    >>> # You aren't expected to understand the code of this test.
    >>> import inspect, ast
    >>> source = inspect.getsource(beaver)
    >>> num_comments = source.count('\\n    #')
    >>> contains_default_line = '"*** YOUR CODE HERE ***"' in source
    >>> num_lines = source.count('\\n') - num_comments
    >>> (num_lines == 2) or (num_lines == 3 and contains_default_line)
    True
    """
    # You don't need to edit this function. It's just here to check your work.


def beaver_run_test():
    """
    Checks to make sure f gets called at least 1000 times.

    >>> counter = 0
    >>> def test():
    ...     global counter
    ...     counter += 1
    >>> beaver(test)
    >>> counter >= 1000
    True
    """
    # You don't need to edit this function. It's just here to check your work.
