Return-Path: <linux-s390+bounces-9736-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7EFA77F07
	for <lists+linux-s390@lfdr.de>; Tue,  1 Apr 2025 17:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5033A5EFF
	for <lists+linux-s390@lfdr.de>; Tue,  1 Apr 2025 15:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A34620AF7B;
	Tue,  1 Apr 2025 15:36:01 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857491E6DC5;
	Tue,  1 Apr 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521761; cv=none; b=rMdOdmQipi6+zVEdvCYCP8L3frHUY/dhbYqfUzPwxrJ66pzbVCEaPDAgU4wSk+k16dRNBICSL7xCrxsewzUzhdfd8fVt0oS94Da1vXC1n18uvR5TBY9shXQsmw234mQU+qMWIarJN124oUnpPQADsms8rITW6wQCVMUf/TbYDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521761; c=relaxed/simple;
	bh=pJCOvKSCNP3r+h21HV73SeQ/4Pz+Jso9BZLFQjDEpRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNCBCnOpPc14O6vLlWsOgbb0w7kz99bd98PQNMRiaxwUd+GQrdu0d1itKcJiUobZumU4AvlEgk6RCnfk/vOm1clpsUZxlYtiWfwqW3zk7G92c00GAQnq89yO2g44mCxhaLnfJu7DKi4OhNkH1adz+7ZY1NO9lrnbc6tC7lWXmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so9181228a12.1;
        Tue, 01 Apr 2025 08:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743521756; x=1744126556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4q7PyMxC5xqAGPRw+fer430fLSzbIyCkfxfyp4wlUFw=;
        b=P31o/Djw3E53g+SVwSwvnbYcIxjYDVl9V7xtT1U02+n4pJ4rAAKQw7A499goelXsVj
         q9JUBgVmObhjnWHiwseH2e8grhCLV2L7ULPu4I2sCfElizuAR0GYX11F0MwQm2dNQ0TA
         Fv6qF0W13Npe9AYn04y33CBMc6FaCB3diWCfxveZU5ftFCrepS2JO+Ae/J4nfHO/4p8V
         CC/5JMpqjolbhCLezAjpqwyMVSNWNQ4x5H9RozRpEg2kLgCzItTXVhRwOCGDOrXUa9uJ
         FmPDwNls+A5pFLCzDWnwB0NalZyoU2d+r5mHTuE3CiXrBjfT/2VE5VaJgNooMJYw+P7n
         tPAg==
X-Forwarded-Encrypted: i=1; AJvYcCU59vcXWby0a82uLH/0ps9BN4d24YnOakZtWlQnbn7n8UylXpcLzgIZ0QiVUPvVai6u+zxbTg==@vger.kernel.org, AJvYcCUiOuQYCrE8/9yBx/XI2SKIOovvRUS+RNfr7J6wGYU/w7AFE5eCk1IqPKfs4+pL/3oebT4on2QtOUSLUg==@vger.kernel.org, AJvYcCUtvBkCAuNU3kBi3X32MLPCULhHA1e8TYbFUtDLwJN60IhKeo7fXqaqcG1eb3CXKyslC7DPQoNPOrC3mA==@vger.kernel.org, AJvYcCVCyF98k3WW7EPtirSCRHss5Tlkm4gChkAwumr0D6HAEnwN/X87vZhCP95qKj9TDEqDnMcFTEz2@vger.kernel.org, AJvYcCVMAspCe+OHfEBC6xLQW+PBV4/km5uzHaaWipQy65N1An9FlpfPsYTrS1Lq6T5T4ZlmdwS2b5lhId0VlA==@vger.kernel.org, AJvYcCVN3+C/DHyzAfJqLuzY1NFVelRFB51CrupnQmNNE0CTHzw1gh8ud3QLyocMZ2BLIiHUrklyess1ss0PLRYo@vger.kernel.org, AJvYcCVSbkPWsKrQnEve8ZoIfkBYmNejNFnLYG1zPwqkOtNdb9uFEcAUgls+gukHPGbzKb1Ke3Y=@vger.kernel.org, AJvYcCVhPjfzzyblyeHNBdv+Mf3VlUGZfnVv7WLqx82Q50J6EZTAo4Vmi0ya2sAVwFqyMox2+dJfD/9m97sopQ==@vger.kernel.org, AJvYcCWD8rGHYD6WmoT2QWw/qichqbXfsXst8iJFr/z2Yy8KTAATHwVxlVjSsROA8C0KVR+kK877A+HQJm2I1w==@vger.kernel.org, AJvYcCWM/bD/6R50DHS8hEibxFlLhzmL5UK2GJWrc0xP
 g2TdoZXpIT0WEDliEj03aOQ9mIfGwVTG6jOIGss=@vger.kernel.org, AJvYcCWMAdMgIVxDkO09K5htFnTufprtvaXnXrnEzEGjBql33GslZcTUQHASYYaEuNonBcb2IXcKY8MbXtdM@vger.kernel.org, AJvYcCWzjDxYxB/rPYkj46A2OxdccTktCgDvqDDioimR6QR4dC8JRC33rGYHVPXqOyAlwk/oRTetpUbhLAQy@vger.kernel.org, AJvYcCXLhqkrcN14mDZK39CKJ3VYHxRC4f1LJGPl1UwgDXEBhQG8WzJ6REi0dDa27RpVTcowIfhzDNy22csmd92qUD2R@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaGUO2XTpXf0NlCYl0w1h2OLzDFbFLYpcSKgIG9T8qjS4pked
	qYEGz2tmh5l2gA7rnwxSmFAn6k23yC83RdNyZ7PQjP+8kdxk+SdH
X-Gm-Gg: ASbGncvKk06p4+xZCY1uQ/UFn1tPqFIOLfOghcRMab9aqKAtZWBWvw9VUCuqmy7FgNM
	2dmCd6Zpj42mIJQaGCGVNuoW3y0+N5PZV+v2HXa4gkGxLxWBWPpeA/a0M7FYwGj2e4J6hf0l9zF
	ITorZN8NOqiK+CU919fj6V2bbq5o3BzXebcqC52G+EYgeh4rBjyKOtNYFu5oof0iMaXWzqv5eT6
	kzdHehDXHlYBUgiQZMECHzJDlFp69ZFjbjyT77li/ghyz3qGVyiie9Ow1iQ6FxM4uunmFgjPNE3
	C+UHdC84mmLCq00LDDKo2aJousufipPqPD8=
X-Google-Smtp-Source: AGHT+IHFJFeJCDIRO8qg0nwWQsfiPbwY1MfkzK1Af/7Jr+VrKkdamoUYCv4u5bbzZ6LGAdCd+o5mpQ==
X-Received: by 2002:a05:6402:348e:b0:5e7:b015:ad42 with SMTP id 4fb4d7f45d1cf-5edfdd21affmr11635868a12.28.1743521755451;
        Tue, 01 Apr 2025 08:35:55 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d4f4bsm7213679a12.30.2025.04.01.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:35:54 -0700 (PDT)
Date: Tue, 1 Apr 2025 08:35:50 -0700
From: Breno Leitao <leitao@debian.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Karsten Keil <isdn@linux-pingi.de>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Joerg Reuter <jreuter@yaina.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	James Chapman <jchapman@katalix.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Martin Schiller <ms@dev.tdt.de>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-hams@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org, dccp@vger.kernel.org,
	linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org,
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
	tipc-discussion@lists.sourceforge.net,
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org,
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
Message-ID: <Z+wH1oYOr1dlKeyN@gmail.com>
References: <cover.1743449872.git.metze@samba.org>
 <Z-sDc-0qyfPZz9lv@mini-arch>
 <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org>
 <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>

On Tue, Apr 01, 2025 at 03:48:58PM +0200, Stefan Metzmacher wrote:
> Am 01.04.25 um 15:37 schrieb Stefan Metzmacher:
> > Am 01.04.25 um 10:19 schrieb Stefan Metzmacher:
> > > Am 31.03.25 um 23:04 schrieb Stanislav Fomichev:
> > > > On 03/31, Stefan Metzmacher wrote:
> > > > > The motivation for this is to remove the SOL_SOCKET limitation
> > > > > from io_uring_cmd_getsockopt().
> > > > > 
> > > > > The reason for this limitation is that io_uring_cmd_getsockopt()
> > > > > passes a kernel pointer as optlen to do_sock_getsockopt()
> > > > > and can't reach the ops->getsockopt() path.
> > > > > 
> > > > > The first idea would be to change the optval and optlen arguments
> > > > > to the protocol specific hooks also to sockptr_t, as that
> > > > > is already used for setsockopt() and also by do_sock_getsockopt()
> > > > > sk_getsockopt() and BPF_CGROUP_RUN_PROG_GETSOCKOPT().
> > > > > 
> > > > > But as Linus don't like 'sockptr_t' I used a different approach.
> > > > > 
> > > > > @Linus, would that optlen_t approach fit better for you?
> > > > 
> > > > [..]
> > > > 
> > > > > Instead of passing the optlen as user or kernel pointer,
> > > > > we only ever pass a kernel pointer and do the
> > > > > translation from/to userspace in do_sock_getsockopt().
> > > > 
> > > > At this point why not just fully embrace iov_iter? You have the size
> > > > now + the user (or kernel) pointer. Might as well do
> > > > s/sockptr_t/iov_iter/ conversion?
> > > 
> > > I think that would only be possible if we introduce
> > > proto[_ops].getsockopt_iter() and then convert the implementations
> > > step by step. Doing it all in one go has a lot of potential to break
> > > the uapi. I could try to convert things like socket, ip and tcp myself, but
> > > the rest needs to be converted by the maintainer of the specific protocol,
> > > as it needs to be tested. As there are crazy things happening in the existing
> > > implementations, e.g. some getsockopt() implementations use optval as in and out
> > > buffer.
> > > 
> > > I first tried to convert both optval and optlen of getsockopt to sockptr_t,
> > > and that showed that touching the optval part starts to get complex very soon,
> > > see https://git.samba.org/?p=metze/linux/wip.git;a=commitdiff;h=141912166473bf8843ec6ace76dc9c6945adafd1
> > > (note it didn't converted everything, I gave up after hitting
> > > sctp_getsockopt_peer_addrs and sctp_getsockopt_local_addrs.
> > > sctp_getsockopt_context, sctp_getsockopt_maxseg, sctp_getsockopt_associnfo and maybe
> > > more are the ones also doing both copy_from_user and copy_to_user on optval)
> > > 
> > > I come also across one implementation that returned -ERANGE because *optlen was
> > > too short and put the required length into *optlen, which means the returned
> > > *optlen is larger than the optval buffer given from userspace.
> > > 
> > > Because of all these strange things I tried to do a minimal change
> > > in order to get rid of the io_uring limitation and only converted
> > > optlen and leave optval as is.
> > > 
> > > In order to have a patchset that has a low risk to cause regressions.
> > > 
> > > But as alternative introducing a prototype like this:
> > > 
> > >          int (*getsockopt_iter)(struct socket *sock, int level, int optname,
> > >                                 struct iov_iter *optval_iter);
> > > 
> > > That returns a non-negative value which can be placed into *optlen
> > > or negative value as error and *optlen will not be changed on error.
> > > optval_iter will get direction ITER_DEST, so it can only be written to.
> > > 
> > > Implementations could then opt in for the new interface and
> > > allow do_sock_getsockopt() work also for the io_uring case,
> > > while all others would still get -EOPNOTSUPP.
> > > 
> > > So what should be the way to go?
> > 
> > Ok, I've added the infrastructure for getsockopt_iter, see below,
> > but the first part I wanted to convert was
> > tcp_ao_copy_mkts_to_user() and that also reads from userspace before
> > writing.
> > 
> > So we could go with the optlen_t approach, or we need
> > logic for ITER_BOTH or pass two iov_iters one with ITER_SRC and one
> > with ITER_DEST...
> > 
> > So who wants to decide?
> 
> I just noticed that it's even possible in same cases
> to pass in a short buffer to optval, but have a longer value in optlen,
> hci_sock_getsockopt() with SOL_BLUETOOTH completely ignores optlen.
> 
> This makes it really hard to believe that trying to use iov_iter for this
> is a good idea :-(

That was my finding as well a while ago, when I was planning to get the
__user pointers converted to iov_iter. There are some weird ways of
using optlen and optval, which makes them non-trivial to covert to
iov_iter.

