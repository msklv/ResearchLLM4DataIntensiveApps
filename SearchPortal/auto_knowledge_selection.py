class Filter:
    async def inlet(
        self,
        body: dict,
        __event_emitter__: Callable[[Any], Awaitable[None]],
        __request__: Any,
        __user__: Optional[dict] = None,
        __model__: Optional[dict] = None,
    ) -> dict:
        # Пример: если обладать логикой выбора Knowledge
        body['features']['knowledge_search'] = True
        body['features']['knowledge_id'] = 'f8ff89fd-ef7e-4360-b2ad-372d7187a188'
        return body
