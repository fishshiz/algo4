class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2

    pivot = array.first
    left = array[1..-1].select { |el| el <= pivot }
    right = array[1..-1].select { |el| el > pivot }

    QuickSort.sort1((left) + [pivot] + (right))
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2

    pivot_idx = partition(array, start, length, &prc)

    left = pivot_idx - start
    right = length - left - 1
    sort2!(array, start, left, &prc)
    sort2!(array, pivot_idx + 1, right, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |i, j| i <=> j }

    pivot_idx = start
    pivot_val = array[start]

    ((start + 1)..(start + length - 1)).each do |idx|
      if prc.call(pivot_val, array[idx]) > 0
        array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end
end
