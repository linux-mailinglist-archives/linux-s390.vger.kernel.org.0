Return-Path: <linux-s390+bounces-2520-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BAA879702
	for <lists+linux-s390@lfdr.de>; Tue, 12 Mar 2024 16:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE1FB20CDD
	for <lists+linux-s390@lfdr.de>; Tue, 12 Mar 2024 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BCB7BAE7;
	Tue, 12 Mar 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRSi07NT"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5816FF3B
	for <linux-s390@vger.kernel.org>; Tue, 12 Mar 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255632; cv=none; b=Ttm9b6RIoVgJWPNfQFC2a4EfWwFJtxUM/Obs0Krf/HDH9ZR6y3uxi23BLOvVJZ7QyYp3GtGge3puRzHGL9hyaP72rM+yy30Y0zCP777hhSSCcHhByHqRxVNKwdanCl6xmOyTs2ayc7dzpPc+26hHw1DoYvQ4iyvnjLUFx2vrCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255632; c=relaxed/simple;
	bh=UDFmtGwIfchIvDyqfrqk65J4W82jwYC/WlPflUtH67s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=toCU1A4H/LcUc9kkJzzRMoWbFuU3QAjFJJfvzKoCz+kY8SGRL8I/7Ci9shkyEkeHIlNvXdRt42rInIlZHQgIZZX36cl1ZsL31TGARm2ipksRapnw98D5EC4Um4Gh7gO4YPttBK5FafRiljDYZLrr0mtAJ2m6OiD6OLl4PrzOm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRSi07NT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710255629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/xER+E4UBqJBEhmSghH9B9OEgRDRYGkaPc9qJ9kFVqA=;
	b=fRSi07NTH6SvHciFQQikb+OSGP5clCB29kt+GbQYmQ5TxF7R2xhwe7OuaLw3HH0m5Mi8vA
	BSmy6dyLRC9+zsKNQNyenjaGu6DuruY9LT0cRkM9UwDzgd3ITQ5TblT4YpZ1rVY7IlBEkW
	rhGNxo4WKejLGM0J0y32hWeKfQ+hCPM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-WMkufW5tO8uUYsnXwiK5mw-1; Tue, 12 Mar 2024 11:00:27 -0400
X-MC-Unique: WMkufW5tO8uUYsnXwiK5mw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33e9151219cso614011f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 12 Mar 2024 08:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710255626; x=1710860426;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xER+E4UBqJBEhmSghH9B9OEgRDRYGkaPc9qJ9kFVqA=;
        b=r+05SY2PSTAO7+4d3kKqSWuzLCz94Yj3oD0n7xWICX54QmhptmeowegFkCLIsisjwJ
         EJb1ZglkhYI/PDjeVfyFzt/SraIHOOOgKQrbtFtkS/rBNIdaY9tP6gDDP5KPLQwwtXnb
         V3V8kQ1X6OHLkUJ/+svb2j0avbN6dBn8DAjbERtXPOaoT/bDdj7Jiad49DOhJB2N6zDb
         jWD2BeMszA2odo3cRBhSPKkAVdr8vbpoJVYNBS+0mZwDVxu1jmrk8XOpQBrKLLW1q74K
         Fth3vDpSb8P45REVrSkGxXtimgx/jc7qk8b43YO/zwsVHmkzd0ywGr/re4dZU9x+WENU
         ZieQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgbpTrNyJ+ep7FOC5Yv1f9CgmJmzeaD9tkBUHPa36OjLnKqobMJDjY7oGskc6u2rKxgfpKmLEj+nO5PHTp1VStMt+lr0MOQ01h6w==
X-Gm-Message-State: AOJu0YzLsISUgq8t9VVwSXXdspSgG8IInUpdutcpLrbd1WttB5VXA/17
	PXB1h97j8z5jRRYBgM9QovJ6eyQyJnPr+IZ+UKuQeWQ0fRzPHibM2l+ea/jt9ZjHfI/7rZ5fLlM
	AxD9oXbWUg5zgF2oJLhwYgBk61mfZrxtyfZudMR7dC6tUq+tRAkDIyauSfi0=
X-Received: by 2002:a05:600c:1c0a:b0:412:ebfe:6891 with SMTP id j10-20020a05600c1c0a00b00412ebfe6891mr1747976wms.4.1710255625654;
        Tue, 12 Mar 2024 08:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaONmo049B88KNui0sys45H/HsQtDmQNHEC1YCVMmei/+uc/7Izo+26oLLe0VtVSCAQC9/ng==
X-Received: by 2002:a05:600c:1c0a:b0:412:ebfe:6891 with SMTP id j10-20020a05600c1c0a00b00412ebfe6891mr1747932wms.4.1710255625037;
        Tue, 12 Mar 2024 08:00:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-128.dyn.eolo.it. [146.241.226.128])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b004131fb3bac4sm11811900wmb.17.2024.03.12.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:00:24 -0700 (PDT)
Message-ID: <29944ce3f034f5373a99b2dcb0d5a5cef906e28e.camel@redhat.com>
Subject: Re: [PATCH net-next v3 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
From: Paolo Abeni <pabeni@redhat.com>
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, 
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com,  tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org,  linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
Date: Tue, 12 Mar 2024 16:00:22 +0100
In-Reply-To: <20240312142743.41406-1-guwen@linux.alibaba.com>
References: <20240312142743.41406-1-guwen@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-12 at 22:27 +0800, Wen Gu wrote:
> This patch set acts as the second part of the new version of [1] (The fir=
st
> part can be referred from [2]), the updated things of this version are li=
sted
> at the end.
>=20
> - Background
>=20
> SMC-D is now used in IBM z with ISM function to optimize network intercon=
nect
> for intra-CPC communications. Inspired by this, we try to make SMC-D avai=
lable
> on the non-s390 architecture through a software-implemented Emulated-ISM =
device,
> that is the loopback-ism device here, to accelerate inter-process or
> inter-containers communication within the same OS instance.
>=20
> - Design
>=20
> This patch set includes 3 parts:
>=20
>  - Patch #1-#2: some prepare work for loopback-ism.
>  - Patch #3-#7: implement loopback-ism device. Noted that loopback-ism no=
w
>    serves only SMC and no userspace interface exposed.
>  - Patch #10-#15: memory copy optimization for intra-OS scenario.
>=20
> The loopback-ism device is designed as an ISMv2 device and not be limited=
 to
> a specific net namespace, ends of both inter-process connection (1/1' in =
diagram
> below) or inter-container connection (2/2' in diagram below) can find the=
 same
> available loopback-ism and choose it during the CLC handshake.
>=20
>  Container 1 (ns1)                              Container 2 (ns2)
>  +-----------------------------------------+    +------------------------=
-+
>  | +-------+      +-------+      +-------+ |    |        +-------+       =
 |
>  | | App A |      | App B |      | App C | |    |        | App D |<-+    =
 |
>  | +-------+      +---^---+      +-------+ |    |        +-------+  |(2')=
 |
>  |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|    =
 |
>  |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+=
 |
>  |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  |=
 |
>  +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+=
-+
>               |   |           |                                  |
>  Kernel       |   |           |                                  |
>  +----+-------v---+-----------v----------------------------------+---+---=
-+
>  |    |                            TCP                               |   =
 |
>  |    |                                                              |   =
 |
>  |    +--------------------------------------------------------------+   =
 |
>  |                                                                       =
 |
>  |                           +--------------+                            =
 |
>  |                           | smc loopback |                            =
 |
>  +---------------------------+--------------+----------------------------=
-+
>=20
> loopback-ism device creates DMBs (shared memory) for each connection peer=
.
> Since data transfer occurs within the same kernel, the sndbuf of each pee=
r
> is only a descriptor and point to the same memory region as peer DMB, so =
that
> the data copy from sndbuf to peer DMB can be avoided in loopback-ism case=
.
>=20
>  Container 1 (ns1)                              Container 2 (ns2)
>  +-----------------------------------------+    +------------------------=
-+
>  | +-------+                               |    |        +-------+       =
 |
>  | | App C |-----+                         |    |        | App D |       =
 |
>  | +-------+     |                         |    |        +-^-----+       =
 |
>  |               |                         |    |          |             =
 |
>  |           (2) |                         |    |     (2') |             =
 |
>  |               |                         |    |          |             =
 |
>  +---------------|-------------------------+    +----------|-------------=
-+
>                  |                                         |
>  Kernel          |                                         |
>  +---------------|-----------------------------------------|-------------=
-+
>  | +--------+ +--v-----+                           +--------+ +--------+ =
 |
>  | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc| =
 |
>  | +-----|--+ +--|-----+                           +-----|--+ +--------+ =
 |
>  | +-----|--+    |                                 +-----|--+            =
 |
>  | | DMB C  |    +---------------------------------| DMB D  |            =
 |
>  | +--------+                                      +--------+            =
 |
>  |                                                                       =
 |
>  |                           +--------------+                            =
 |
>  |                           | smc loopback |                            =
 |
>  +---------------------------+--------------+----------------------------=
-+
>=20
> - Benchmark Test
>=20
>  * Test environments:
>       - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>       - SMC sndbuf/DMB size 1MB.
>=20
>  * Test object:
>       - TCP: run on TCP loopback.
>       - SMC lo: run on SMC loopback-ism.
>=20
> 1. ipc-benchmark (see [3])
>=20
>  - ./<foo> -c 1000000 -s 100
>=20
>                             TCP                  SMC-lo
> Message
> rate (msg/s)              81433                  143938(+76.75%)
>=20
> 2. sockperf
>=20
>  - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
>  - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size=
=3D{ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
>=20
>                             TCP                  SMC-lo
> Bandwidth(MBps)         4903.07                 7978.69(+62.73%)
> Latency(us)               6.095                   3.539(-41.94%)
>=20
> 3. nginx/wrk
>=20
>  - serv: <smc_run> nginx
>  - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
>=20
>                            TCP                   SMC-lo
> Requests/s           161665.67                244272.41(+51.10%)
>=20
> 4. redis-benchmark
>=20
>  - serv: <smc_run> redis-server
>  - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -=
c 200 -d 1024
>=20
>                            TCP                   SMC-lo
> GET(Requests/s)       88790.23                117474.30(+32.31%)
> SET(Requests/s)       87508.20                118623.96(+35.57%)
>=20
>=20
> Change log:
>=20
> v3->v2:
> - Patch #11: use tasklet_schedule(&conn->rx_tsklet) instead of smcd_cdc_r=
x_handler()
>   to avoid possible recursive locking of conn->send_lock and use {read|wr=
ite}_lock_bh()
>   to acquire dmb_ht_lock.
>=20
> v2->v1:
> Link: https://lore.kernel.org/netdev/20240307095536.29648-1-guwen@linux.a=
libaba.com/
> - All the patches: changed the term virtual-ISM to Emulated-ISM as define=
d by SMCv2.1.
> - Patch #3: optimized the description of SMC_LO config. Avoid exposing lo=
opback-ism
>   to sysfs and remove all the knobs until future definition clear.
> - Patch #3: try to make lockdep happy by using read_lock_bh() in smc_lo_m=
ove_data().
> - Patch #6: defaultly use physical contiguous DMB buffers.
> - Patch #11: defaultly enable DMB no-copy for loopback-ism and free the D=
MB in
>   unregister_dmb or detach_dmb when dmb_node->refcnt reaches 0, instead o=
f using
>   wait_event to keep waiting in unregister_dmb.
>=20
> v1->RFC:
> Link: https://lore.kernel.org/netdev/20240111120036.109903-1-guwen@linux.=
alibaba.com/
> - Patch #9: merge rx_bytes and tx_bytes as xfer_bytes statistics:
>   /sys/devices/virtual/smc/loopback-ism/xfer_bytes
> - Patch #10: add support_dmb_nocopy operation to check if SMC-D device su=
pports
>   merging sndbuf with peer DMB.
> - Patch #13 & #14: introduce loopback-ism device control of DMB memory ty=
pe and
>   control of whether to merge sndbuf and DMB. They can be respectively se=
t by:
>   /sys/devices/virtual/smc/loopback-ism/dmb_type
>   /sys/devices/virtual/smc/loopback-ism/dmb_copy
>   The motivation for these two control is that a performance bottleneck w=
as
>   found when using vzalloced DMB and sndbuf is merged with DMB, and there=
 are
>   many CPUs and CONFIG_HARDENED_USERCOPY is set [4]. The bottleneck is ca=
used
>   by the lock contention in vmap_area_lock [5] which is involved in memcp=
y_from_msg()
>   or memcpy_to_msg(). Currently, Uladzislau Rezki is working on mitigatin=
g the
>   vmap lock contention [6]. It has significant effects, but using virtual=
 memory
>   still has additional overhead compared to using physical memory.
>   So this new version provides controls of dmb_type and dmb_copy to suit
>   different scenarios.
> - Some minor changes and comments improvements.
>=20
## Form letter - net-next-closed

The merge window for v6.9 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes
only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle

--=20
pw-bot: defer



