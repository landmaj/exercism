defmodule HighSchoolSweetheart do
  @spec first_letter(String.t) :: String.t
  def first_letter(name) do
    name
    |> String.trim()
    |> String.first()
  end

  @spec initial(String.t) :: String.t
  def initial(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> Kernel.<>(".")
  end

  @spec initials(String.t) :: String.t
  def initials(full_name) do
    full_name
    |> String.split()
    |> Enum.map(&initial/1)
    |> Enum.join(" ")
  end

  @spec pair(String.t, String.t) :: String.t
  def pair(full_name1, full_name2) do
    i1 = initials(full_name1)
    i2 = initials(full_name2)
    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{i1}  +  #{i2}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
