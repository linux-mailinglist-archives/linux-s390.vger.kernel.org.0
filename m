Return-Path: <linux-s390+bounces-933-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A882B0EE
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jan 2024 15:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E601F22002
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F0E15E96;
	Thu, 11 Jan 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="q4Rd2nzR"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC84A987
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7af5f618so6145878e87.1
        for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 06:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704984615; x=1705589415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEyGSllYt9OxPetcB8D76c/PruL4Th1B1cxlxtL+brQ=;
        b=q4Rd2nzRzqb0LCvVFZGyTRYoUNIm9bZty5rEobxjYDQuq+b4AVrpEEI2dH4KeIaHro
         SysdjD1CBFXVG3fqVKKVfVrTfRkxZcAcd35BVo9wHZQcAojCujkpOURZK60wzTHgtTbf
         9ranOxaEX9KAJXIzUVae/6kE2aJC/e3BDAke0qcZF7wg6MjxWHWgXKAvamWdA6DoSUUD
         O/926NNtNyjizKuhFl8Fnq8qzNgXBUHrpUPS5aU/6O+Q6CPkqzYdBvgaS6sczErd916U
         TUrlKOq74z3BC/Fr7M+5U6g4PAOk7OFhkWTm45FR74Oyrmf5Pl/um0FO0me8Q9vWPjig
         64gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704984615; x=1705589415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEyGSllYt9OxPetcB8D76c/PruL4Th1B1cxlxtL+brQ=;
        b=QvP1thyZSIUNEp6VlygCQahIWtAWQKmFHd1Kt+qgYHA0r5/pMsTKeJZbYDwlprR6ET
         5phCGy4iRsbk0zkLkKO5QOVF2YsGHuiyyRv6tOlP3E+Jpq1TMUBDUcFC0J3Uy5GJmWhG
         lJOg+aB0sbRY4VEtspywLuIDp7SXtYRqmLuVhnzcw+svdfC3sSxhMtb4eUU7sftRrrt2
         JhMCEENpPsQUDVqziPjYHnEi0fYQHFuEVt9WQuxCkZG/+dFfDfSuLSt1JZj0g4fSszXH
         g7r7Elza8Ed5fj8uXA016Vtfpbn4Xk+B0cexoUfWY9pOvirs8DMBEnPtxJwl1UUYbq6m
         MF2A==
X-Gm-Message-State: AOJu0Yx+i0q4SX9Pg6yZ/+vRKrnA9qeQ/Hn0gujT8yw3wdZIMWSsbCly
	VDoZE47O9egweJCVihOsRF3An5jcxPCDeA==
X-Google-Smtp-Source: AGHT+IGYiLKyvOgTCBH2tHlSIlEVKsqb/0h126uTNT0yhvgBpzrEefbBWxF2tBiv6r0AT9hzP59cwA==
X-Received: by 2002:ac2:44a7:0:b0:50e:7709:a06e with SMTP id c7-20020ac244a7000000b0050e7709a06emr661289lfm.99.1704984615162;
        Thu, 11 Jan 2024 06:50:15 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709066dcf00b00a2a6e8f693esm654747ejt.152.2024.01.11.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:50:13 -0800 (PST)
Date: Thu, 11 Jan 2024 15:50:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jaka@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
Message-ID: <ZaAAJDiQ3bPGGRFK@nanopsycho>
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111120036.109903-1-guwen@linux.alibaba.com>

Thu, Jan 11, 2024 at 01:00:21PM CET, guwen@linux.alibaba.com wrote:
>This patch set acts as the second part of the new version of [1] (The first
>part can be referred from [2]), the updated things of this version are listed
>at the end.
>
># Background
>
>SMC-D is now used in IBM z with ISM function to optimize network interconnect
>for intra-CPC communications. Inspired by this, we try to make SMC-D available

Care to provide more details about what ISM and intra-CPC is and what it
it good for?


>on the non-s390 architecture through a software-implemented virtual ISM device,
>that is the loopback-ism device here, to accelerate inter-process or

I see no such device. Is it a netdevice?

If it is "software-implemented", why is it part of smc driver and not
separate soft-device driver? If there is some smc specific code, I guess
there should be some level of separation. Can't this be implemented by
other devices too?



>inter-containers communication within the same OS instance.
>
># Design
>
>This patch set includes 3 parts:
>
> - Patch #1-#2: some prepare work for loopback-ism.
> - Patch #3-#9: implement loopback-ism device.
> - Patch #10-#15: memory copy optimization for loopback scenario.
>
>The loopback-ism device is designed as a ISMv2 device and not be limited to
>a specific net namespace, ends of both inter-process connection (1/1' in diagram
>below) or inter-container connection (2/2' in diagram below) can find the same
>available loopback-ism and choose it during the CLC handshake.
>
> Container 1 (ns1)                              Container 2 (ns2)
> +-----------------------------------------+    +-------------------------+
> | +-------+      +-------+      +-------+ |    |        +-------+        |
> | | App A |      | App B |      | App C | |    |        | App D |<-+     |
> | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
> |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
> |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
> |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
> +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
>              |   |           |                                  |
> Kernel       |   |           |                                  |
> +----+-------v---+-----------v----------------------------------+---+----+
> |    |                            TCP                               |    |
> |    |                                                              |    |
> |    +--------------------------------------------------------------+    |
> |                                                                        |
> |                           +--------------+                             |
> |                           | smc loopback |                             |
> +---------------------------+--------------+-----------------------------+
>
>loopback-ism device creates DMBs (shared memory) for each connection peer.
>Since data transfer occurs within the same kernel, the sndbuf of each peer
>is only a descriptor and point to the same memory region as peer DMB, so that
>the data copy from sndbuf to peer DMB can be avoided in loopback-ism case.
>
> Container 1 (ns1)                              Container 2 (ns2)
> +-----------------------------------------+    +-------------------------+
> | +-------+                               |    |        +-------+        |
> | | App C |-----+                         |    |        | App D |        |
> | +-------+     |                         |    |        +-^-----+        |
> |               |                         |    |          |              |
> |           (2) |                         |    |     (2') |              |
> |               |                         |    |          |              |
> +---------------|-------------------------+    +----------|--------------+
>                 |                                         |
> Kernel          |                                         |
> +---------------|-----------------------------------------|--------------+
> | +--------+ +--v-----+                           +--------+ +--------+  |
> | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc|  |
> | +-----|--+ +--|-----+                           +-----|--+ +--------+  |
> | +-----|--+    |                                 +-----|--+             |
> | | DMB C  |    +---------------------------------| DMB D  |             |
> | +--------+                                      +--------+             |
> |                                                                        |
> |                           +--------------+                             |
> |                           | smc loopback |                             |
> +---------------------------+--------------+-----------------------------+
>
># Benchmark Test
>
> * Test environments:
>      - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>      - SMC sndbuf/DMB size 1MB.
>      - /sys/devices/virtual/smc/loopback-ism/dmb_copy is set to default 0,
>        which means sndbuf and DMB are merged and no data copied between them.
>      - /sys/devices/virtual/smc/loopback-ism/dmb_type is set to default 0,

Exposing any configuration knobs and statistics over sysfs for
softdevices does not look correct at all :/ Could you please avoid
sysfs?


>        which means DMB is physically contiguous buffer.
>
> * Test object:
>      - TCP: run on TCP loopback.
>      - SMC lo: run on SMC loopback device.
>
>1. ipc-benchmark (see [3])
>
> - ./<foo> -c 1000000 -s 100
>
>                            TCP                  SMC-lo
>Message
>rate (msg/s)              80636                  149515(+85.42%)
>
>2. sockperf
>
> - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
> - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
>
>                            TCP                  SMC-lo
>Bandwidth(MBps)         4909.36                 8197.57(+66.98%)
>Latency(us)               6.098                   3.383(-44.52%)
>
>3. nginx/wrk
>
> - serv: <smc_run> nginx
> - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
>
>                           TCP                   SMC-lo
>Requests/s           181685.74                246447.77(+35.65%)
>
>4. redis-benchmark
>
> - serv: <smc_run> redis-server
> - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
>
>                           TCP                   SMC-lo
>GET(Requests/s)       85855.34                118553.64(+38.09%)
>SET(Requests/s)       86824.40                125944.58(+45.06%)
>
>
>Change log:
>
>v1->RFC:
>- Patch #9: merge rx_bytes and tx_bytes as xfer_bytes statistics:
>  /sys/devices/virtual/smc/loopback-ism/xfer_bytes
>- Patch #10: add support_dmb_nocopy operation to check if SMC-D device supports
>  merging sndbuf with peer DMB.
>- Patch #13 & #14: introduce loopback-ism device control of DMB memory type and
>  control of whether to merge sndbuf and DMB. They can be respectively set by:
>  /sys/devices/virtual/smc/loopback-ism/dmb_type
>  /sys/devices/virtual/smc/loopback-ism/dmb_copy
>  The motivation for these two control is that a performance bottleneck was
>  found when using vzalloced DMB and sndbuf is merged with DMB, and there are
>  many CPUs and CONFIG_HARDENED_USERCOPY is set [4]. The bottleneck is caused
>  by the lock contention in vmap_area_lock [5] which is involved in memcpy_from_msg()
>  or memcpy_to_msg(). Currently, Uladzislau Rezki is working on mitigating the
>  vmap lock contention [6]. It has significant effects, but using virtual memory
>  still has additional overhead compared to using physical memory.
>  So this new version provides controls of dmb_type and dmb_copy to suit
>  different scenarios.
>- Some minor changes and comments improvements.
>
>RFC->old version([1]):
>Link: https://lore.kernel.org/netdev/1702214654-32069-1-git-send-email-guwen@linux.alibaba.com/
>- Patch #1: improve the loopback-ism dump, it shows as follows now:
>  # smcd d
>  FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>  0000 0     loopback-ism  ffff   No        0
>- Patch #3: introduce the smc_ism_set_v2_capable() helper and set
>  smc_ism_v2_capable when ISMv2 or virtual ISM is registered,
>  regardless of whether there is already a device in smcd device list.
>- Patch #3: loopback-ism will be added into /sys/devices/virtual/smc/loopback-ism/.
>- Patch #8: introduce the runtime switch /sys/devices/virtual/smc/loopback-ism/active
>  to activate or deactivate the loopback-ism.
>- Patch #9: introduce the statistics of loopback-ism by
>  /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.
>- Some minor changes and comments improvements.
>
>[1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
>[2] https://lore.kernel.org/netdev/20231219142616.80697-1-guwen@linux.alibaba.com/
>[3] https://github.com/goldsborough/ipc-bench
>[4] https://lore.kernel.org/all/3189e342-c38f-6076-b730-19a6efd732a5@linux.alibaba.com/
>[5] https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
>[6] https://lore.kernel.org/all/20240102184633.748113-1-urezki@gmail.com/
>
>Wen Gu (15):
>  net/smc: improve SMC-D device dump for virtual ISM
>  net/smc: decouple specialized struct from SMC-D DMB registration
>  net/smc: introduce virtual ISM device loopback-ism
>  net/smc: implement ID-related operations of loopback-ism
>  net/smc: implement some unsupported operations of loopback-ism
>  net/smc: implement DMB-related operations of loopback-ism
>  net/smc: register loopback-ism into SMC-D device list
>  net/smc: introduce loopback-ism runtime switch
>  net/smc: introduce loopback-ism statistics attributes
>  net/smc: add operations to merge sndbuf with peer DMB
>  net/smc: attach or detach ghost sndbuf to peer DMB
>  net/smc: adapt cursor update when sndbuf and peer DMB are merged
>  net/smc: introduce loopback-ism DMB type control
>  net/smc: introduce loopback-ism DMB data copy control
>  net/smc: implement DMB-merged operations of loopback-ism
>
> drivers/s390/net/ism_drv.c |   2 +-
> include/net/smc.h          |   7 +-
> net/smc/Kconfig            |  13 +
> net/smc/Makefile           |   2 +-
> net/smc/af_smc.c           |  28 +-
> net/smc/smc_cdc.c          |  58 ++-
> net/smc/smc_cdc.h          |   1 +
> net/smc/smc_core.c         |  61 +++-
> net/smc/smc_core.h         |   1 +
> net/smc/smc_ism.c          |  71 +++-
> net/smc/smc_ism.h          |   5 +
> net/smc/smc_loopback.c     | 718 +++++++++++++++++++++++++++++++++++++
> net/smc/smc_loopback.h     |  88 +++++
> 13 files changed, 1026 insertions(+), 29 deletions(-)
> create mode 100644 net/smc/smc_loopback.c
> create mode 100644 net/smc/smc_loopback.h
>
>-- 
>2.32.0.3.g01195cf9f
>
>

