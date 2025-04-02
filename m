Return-Path: <linux-s390+bounces-9744-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E8A785CE
	for <lists+linux-s390@lfdr.de>; Wed,  2 Apr 2025 02:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFB83AB334
	for <lists+linux-s390@lfdr.de>; Wed,  2 Apr 2025 00:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D92E3365;
	Wed,  2 Apr 2025 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OMZKek6k"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0721AAC9
	for <linux-s390@vger.kernel.org>; Wed,  2 Apr 2025 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743554838; cv=none; b=bjMqsr9dFV1EuQOHIL+tM1KQ/BVMqY50lVPfqmw5txQdKgntGLRCNNf1yZf84GzoDrprCW9M+FvAg6girW8SLkq5JUlvZgR2a5L6lOsPdeG8Ju5/561DDV5NbHdzD/wqXRqQPEmBBh8g7RKkMFu5tMX+SbBb1gU/huJ8GQbyvgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743554838; c=relaxed/simple;
	bh=gKvtz1iMes15Dk29gHgnGLSQ0AzIDyIu+TI574Yzf08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ozp9q1kDNpA95+bCLaPKJ1PjhssePZv/QPBJhahncIX/FH5i0xBo/D6TLmgNqXVHcVFsm5JheKQixSkEzjELccbRFXIkC9p7TyEiZ2fEk1kX9+Tnz81+i9VY//VgxDS4Id0J7rtcxSRnZ2d1cCg/2OyoGcOhcCLKEXEr+51nK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OMZKek6k; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso62934566b.1
        for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 17:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743554834; x=1744159634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vu/Ham6OvzEjp0kQLpwOmOKgb686vhg9IiykSVIyewU=;
        b=OMZKek6kA9tUhokVJV/I8vz605LAd6XYZXA/yHQGjxvs5zqJ3RTt+bpOce2iRydM7Y
         FWrBCEhqmw+8JZanadgYOb+CQsLLKF4d2SuBOGpvwPMcsNqXk3gsntEgcZCW5fIFWebl
         /ezes/GboWSL8Gd5ZbET6Oo75A2jX+WGQz+GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743554834; x=1744159634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vu/Ham6OvzEjp0kQLpwOmOKgb686vhg9IiykSVIyewU=;
        b=tFrj9i1cKbUqxtGpLshAhsOaDrP9xynLuXh7kf0XKhsGRYuT5NB5UzXfvcj7TL3/ah
         9X+qWVJsgdhZ+8+MkrMwDX78nZhc/z1snmhC12gYZbpNDVZ/HpjaRBTPJuZQn1HD9qrs
         IYjcai24jX8DCxgnrujqs9e7kkuywFORxBUa1KcS18oFxdNu9bAZ/iLNbjVPAxtDlz99
         an/yDG0U2odZrJtizufkicdGQ0KMkXYNil66WesHJf6pk5ODM7BUO9+Fq1iwVOlY3z4M
         1cEjdfNMKGmVmd8zGAQVLlWCx45VUDLuQxS3WGR3ex1f1GKsnEj8ZX4E4JiGhQhwdyc6
         YS/A==
X-Forwarded-Encrypted: i=1; AJvYcCUrqmUQL2qTV1ptthZlmzRSZM6zrWlQkKPolRCENL4MvPbjMg+Tr47UyhUD8ou1eEz8Y5MiPyUuCFs+@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnYKVYz/37D4IuHQnfvwsfl+CB34cSZnccupedo4SOv1IV42T
	Yjtojf7cCdWDqe2y4Th0jxn8DVv/Qf5Q65aoF4zoTG8wbrnliXxP7LWE/4XBzNwkcalF1qqZVkk
	9ry0=
X-Gm-Gg: ASbGncuvQ3GtNasWq/D1ThfZ1lll94o7833BFkwLS88ov47nLmuBOyoyVGtuSebKjhC
	tU8HaVw1+sMPlrdrVPmizXBb37FQ6IhrbMNolrGE6klwVB19JTYdkwL8Fi4Mm+8itpFIuxLETsK
	HEm2yvp4XgnQ7MMvN90Z6jsxW6zUOHULsN5fmslj+fUzzm3Wq+bxZev0cFlqP4MyfdWiMxYuc87
	T2Kahdi3iLac9n9ZNg/zUH4v30ZufWeMHSPMXuUNGTUs3EzH53Y7tuhWZg1CtBJf7EChyGR/h+x
	nblVhovcrCx7BdDQ31kzxix2+9AgZtHyZ5vZevV3OQHfasJPrB1qPYPbX1/tt9dSraHHntFj2VJ
	0ZEbW1NNS2LKzM064HvY=
X-Google-Smtp-Source: AGHT+IHQo7ZaYgBmok0aS8isTF5EJigtXhAxhQ93XFq/xhvPWtpVt3wWDkgkBKE4+COS0i+UFqU1SA==
X-Received: by 2002:a17:907:60d0:b0:ac1:dde7:b57f with SMTP id a640c23a62f3a-ac7a5cf5286mr4974466b.23.1743554833814;
        Tue, 01 Apr 2025 17:47:13 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719278259sm839595766b.38.2025.04.01.17.47.11
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 17:47:12 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so691812a12.1
        for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 17:47:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb+mmvNlbGKOpIEcuIwJB8dTMChsHGarKVVsgssaIimAlRZWpowDLmWxgu5+uEB/ve8zxAwBHmI5cN@vger.kernel.org
X-Received: by 2002:a17:906:5a58:b0:ac6:b80b:2331 with SMTP id
 a640c23a62f3a-ac7a5a6a7femr5394166b.4.1743554436373; Tue, 01 Apr 2025
 17:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743449872.git.metze@samba.org>
In-Reply-To: <cover.1743449872.git.metze@samba.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 1 Apr 2025 17:40:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com>
X-Gm-Features: AQ5f1JqzSUFwvrLn7ljSUlWXdbqdVpjtPJUQgf_7X3eWbMud67Mtv15-jjUkgBs
Message-ID: <CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: Stefan Metzmacher <metze@samba.org>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"

On Mon, 31 Mar 2025 at 13:11, Stefan Metzmacher <metze@samba.org> wrote:
>
> But as Linus don't like 'sockptr_t' I used a different approach.

So the sockptr_t thing has already happened. I hate it, and I think
it's ugly as hell, but it is what it is.

I think it's a complete hack and having that "kernel or user" pointer
flag is disgusting.

Making things worse, the naming is disgusting too, talking about some
random "socket pointer", when it has absolutely nothing to do with
socket, and isn't even a pointer. It's something else.

It's literally called "socket" not because it has anything to do with
sockets, but because it's a socket-specific hack that isn't acceptable
anywhere else in the kernel.

So that "socket" part of the name is literally shorthand for "only
sockets are disgusting enough to use this, and nobody else should ever
touch this crap".

At least so far that part has mostly worked, even if there's some
"sockptr_t" use in the crypto code. I didn't look closer, because I
didn't want to lose my lunch.

I don't understand why the networking code uses that thing.

If you have a "fat pointer", you should damn well make it have the
size of the area too, and do things *right*.

Instead of doing what sockptr_t does, which is a complete hack to just
pass a kernel/user flag, and then passes the length *separately*
because the socket code couldn't be arsed to do the right thing.

So I do still think "sockptr_t" should die.

As Stanislav says, if you actually want that "user or kernel" thing,
just use an "iov_iter".

No, an "iov_iter" isn't exactly a pretty thing either, but at least
it's the standard way to say "this pointer can have multiple different
kinds of sources".

And it keeps the size of the thing it points to around, so it's at
least a fat pointer with proper ranges, even if it isn't exactly "type
safe" (yes, it's type safe in the sense that it stays as a "iov_iter",
but it's still basically a "random pointer").

> @Linus, would that optlen_t approach fit better for you?

The optlen_t thing is slightly better mainly because it's more
type-safe. At least it's not a "random misnamed
user-or-kernel-pointer" thing where the name is about how nothing else
is so broken as to use it.

So it's better because it's more limited, and it's better in that at
least it has a type-safe pointer rather than a "void *" with no size
or type associated with it.

That said, I don't think it's exactly great.

It's just another case of "networking can't just do it right, and uses
a random hack with special flag values".

So I do think that it would be better to actually get rid of
"sockptr_t optval, unsigned int optlen" ENTIRELY, and replace that
with iov_iter and just make networking bite the bullet and do the
RightThing(tm).

In fact, to make it *really* typesafe, it might be a good idea to wrap
the iov_iter in another struct, something like

   typedef struct sockopt {
        struct iov_iter iter;
   } sockopt_t;

and make the networking functions make the typing very clear, and end
up with an interface something like

   int do_tcp_setsockopt(struct sock *sk,
                     int level, int optname,
                     sockopt_t *val);

where that "sockopt_t *val" replaces not just the "sockptr_t optval",
but also the "unsigned int optlen" thing.

And no, I didn't look at how much churn that would be. Probably a lot.
Maybe more than people are willing to do - even if I think some of it
could be automated with coccinelle or whatever.

                Linus

