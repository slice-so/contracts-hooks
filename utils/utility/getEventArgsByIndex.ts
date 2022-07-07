import { Event } from "ethers"

export const getEventArgsByIndex = (
  events: Event[] | undefined,
  name: string,
  args: number[]
) => {
  const event = events?.filter((event) => event.event === name)[0]
  let returnedArgs: any[] = []
  args.forEach((arg) => {
    const eventArgs = event?.args as any[]
    returnedArgs.push(eventArgs[arg])
  })
  return returnedArgs
}
