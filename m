Return-Path: <linux-s390+bounces-4725-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E619143C4
	for <lists+linux-s390@lfdr.de>; Mon, 24 Jun 2024 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F631C20B05
	for <lists+linux-s390@lfdr.de>; Mon, 24 Jun 2024 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB163B1BC;
	Mon, 24 Jun 2024 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XVaHNUHq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qd2K4LAK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DKSLEMpj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JlzHUa78"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C8FBEF;
	Mon, 24 Jun 2024 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214482; cv=none; b=sRIhpHJbn59LTcrX2R/HBrY/QKiyINE6z9qIKGNNaotDh/NLo3o3RFDtz9mXAEg5MgjISDX4EzY2AInnXIrIG6ydT0A22qLCXxj3ghTtS9AF7kGWJ+0jEXeEXn3E0WF2iuU65FurQlheYXcR55rThMn+hz/Cp/J8jSavQXDp594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214482; c=relaxed/simple;
	bh=IR9H7UT1JweXlJUcolJZltrVBI2Q1eMGx3A3+6e6XGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rj3tmKql1QrpncV1mLmA9hY7f+g873iqX3yx6WWnnGybdDdAB11jM/d0+BmGzWjmX690ft3+KkTn55AuhTgooUawGDQ+kqM3A53s66tpSmHpSiX8Zv93hyyEL6TXgtaSdPutMj+M8WNUE+RtyN1AFvdOg4G9o9V6QonvaoEiAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XVaHNUHq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qd2K4LAK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DKSLEMpj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JlzHUa78; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E640F1F7C0;
	Mon, 24 Jun 2024 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719214479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n9uIGGVbJ8r8fxtPRtb3rTWtvj0CS+kX8qbLDmwrsbk=;
	b=XVaHNUHq8Q2UDyjmR1Uc8c+pnb+1HlnOHUGI8PNeNyGJFxKSYtHiyRIzW91G5ViJJ/PVrY
	Nsd8ZCzYSR/iZ1/BtTrXdiHblE37noVzbN1Tby/+PlVw7fOqU6fIKpaeLj1Q7jV/pBp4N6
	bo6RtIdW41wxUtdIY1LuGZ/73sA+DXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719214479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n9uIGGVbJ8r8fxtPRtb3rTWtvj0CS+kX8qbLDmwrsbk=;
	b=Qd2K4LAKLMK1Zg3tpCpF6loLPWVw2azJjp5tZm+NhagFm22xzd8MNaDsMH7p9uuGmGk8Fk
	ADsxWdZgDjDzxfAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DKSLEMpj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JlzHUa78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719214478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n9uIGGVbJ8r8fxtPRtb3rTWtvj0CS+kX8qbLDmwrsbk=;
	b=DKSLEMpjLtGSecYXX2VzYOP616fe91mMVkEWpuR7I86wyHAisOc1EbgJSYmMU02+TT6bl5
	ynM6/TkjNnCowa7HxOAkxsWT6KRFzhABddxBXHnRwZKkCmomXEtc/X+6LRoPUDjOzEFR3b
	Imgon5ufBfn74aU59k5LNWhzqoC+O7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719214478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n9uIGGVbJ8r8fxtPRtb3rTWtvj0CS+kX8qbLDmwrsbk=;
	b=JlzHUa78dHwS2tZCLD7XdUV7IlNQ1ON0WFTZUZwngjZ0XZhSDFg2EdDUzvSP6R9JxCnlE8
	5PhprITz11gEutBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B26D813ACD;
	Mon, 24 Jun 2024 07:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qB+lKo4heWb8fgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 24 Jun 2024 07:34:38 +0000
Message-ID: <56e9564d-0b01-484c-a491-acd6d15e0b26@suse.cz>
Date: Mon, 24 Jun 2024 09:34:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/38] mm: slub: Disable KMSAN when checking the
 padding bytes
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sven Schnelle <svens@linux.ibm.com>
References: <20240621113706.315500-1-iii@linux.ibm.com>
 <20240621113706.315500-19-iii@linux.ibm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240621113706.315500-19-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,google.com,gmail.com,googlegroups.com,vger.kernel.org,kvack.org,arm.com,linux.dev];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E640F1F7C0
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Spam-Level: 

On 6/21/24 1:35 PM, Ilya Leoshkevich wrote:
> Even though the KMSAN warnings generated by memchr_inv() are suppressed
> by metadata_access_enable(), its return value may still be poisoned.
> 
> The reason is that the last iteration of memchr_inv() returns
> `*start != value ? start : NULL`, where *start is poisoned. Because of
> this, somewhat counterintuitively, the shadow value computed by
> visitSelectInst() is equal to `(uintptr_t)start`.
> 
> One possibility to fix this, since the intention behind guarding
> memchr_inv() behind metadata_access_enable() is to touch poisoned
> metadata without triggering KMSAN, is to unpoison its return value.
> However, this approach is too fragile. So simply disable the KMSAN
> checks in the respective functions.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b050e528112c..fcd68fcea4ab 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1176,9 +1176,16 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
>  	memset(from, data, to - from);
>  }
>  
> -static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> -			u8 *object, char *what,
> -			u8 *start, unsigned int value, unsigned int bytes)
> +#ifdef CONFIG_KMSAN
> +#define pad_check_attributes noinline __no_kmsan_checks
> +#else
> +#define pad_check_attributes
> +#endif
> +
> +static pad_check_attributes int
> +check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> +		       u8 *object, char *what,
> +		       u8 *start, unsigned int value, unsigned int bytes)
>  {
>  	u8 *fault;
>  	u8 *end;
> @@ -1270,7 +1277,8 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
>  }
>  
>  /* Check the pad bytes at the end of a slab page */
> -static void slab_pad_check(struct kmem_cache *s, struct slab *slab)
> +static pad_check_attributes void
> +slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  {
>  	u8 *start;
>  	u8 *fault;


