Return-Path: <linux-s390+bounces-4466-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC8490F02E
	for <lists+linux-s390@lfdr.de>; Wed, 19 Jun 2024 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F9B286A1E
	for <lists+linux-s390@lfdr.de>; Wed, 19 Jun 2024 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2C1EA84;
	Wed, 19 Jun 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YYKvsL3V"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26712168C7
	for <linux-s390@vger.kernel.org>; Wed, 19 Jun 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806726; cv=none; b=iKssjEy42Wudg0Zxt+1KHWY36KpmPtYUpGXXlO3pX04UAgGHZt55Zf8Raurxl5uUOlddWedjOAR9T9bsbKnE6HWjczRsJoBF47sUjSmqPKSw9Hr8lZPyt0XjoX8j7Z/qmIBSFV2l9NTPTBPKoPhhr97DwofEqZgd9aurrfDJULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806726; c=relaxed/simple;
	bh=QWK4q+Z6QaRcjKIsA7MnW3f/QFVZHOJVpMu7UnF/4Ms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uF8v/owilms/fHcTKvagqzprtRFIWk1XUSMpwT+SKIZhAt6bSpfKfMxnUJ2YxxgST+PrK2NNio3H/hTYqThiHyjzguf6ezKrnlpNVg/7aI2bA0JRSAQdW1Kb8RZ2YgCXJWW792o+Df4wrBtPrrvMYTk+J0PcM80SE36V/A+pKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YYKvsL3V; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6e3341c8767so200246a12.0
        for <linux-s390@vger.kernel.org>; Wed, 19 Jun 2024 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718806723; x=1719411523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVFpcyqMw7891fhn8oME2l6O88u8sGFZorCmmUmii2A=;
        b=YYKvsL3V7pFte5XJ+EgV6Rr/aZQKDUNVDjBzLYhcJOZY9sv3lahrntnmepmQ1N/nsE
         kMvwP/e87x23xbRXg6l611pPSUDb2onpuOWYkCGXQ7NtaDqq+YOGOFD9XiZ/ZRQO9DOx
         VeocFfIQ61zRcVGgIKpqe/Ckdbsx8HxTk8Wv/LvgIGUL8Crkdh+orFTuksw6ceLd6pfe
         TWIAkqwCz7ablOCKmpnwXK+s/k/1CLq7D1GOR3TlJJf2xBv0cqZ6g13XMZC/QjAJb0yp
         /szfdrT8dBU/XeRzCN7VaBOzWf6+41YxO2boQ0vuoJRNJwD8pEbOK0DUgLebnjyEr3rQ
         tvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806723; x=1719411523;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVFpcyqMw7891fhn8oME2l6O88u8sGFZorCmmUmii2A=;
        b=xHe10mIJpA3oONZjYZgouDB7gTPwHEmAHu2ORMlEC3auiEC8yLD/Q94XO4RVEPaMBH
         2smaypmm3KVrHtHDHUnCHOjCCx3o1bBlhVb7uoux598xWDREYmuQoxDNN6Rngj0ORqLM
         MrixQN90gHzC2HZ9XAmPfxZQmWpKjhtThPzyGxuph1FBR9SiDNAXyOChKLbDWwoF+ej7
         qdfeh9BAjJhgjVznh8Tse5BmaxgqVX1n6RzvInqWxj8fAgv7/TdrNFmikubmRfhh4LE7
         yohtsJrHCX9vOg7u2XsvFHHacrzd2YUD1Ga557GRCb6oC/V937X9l5WJXwGfKcwIJod2
         5pgg==
X-Forwarded-Encrypted: i=1; AJvYcCU9sJjMY/JoQji5MIlBsie7o0Y6eeTaDN63BFjifVY+WP6XftBerCozHYjYnuGby1sbZa1bqCmvPdSG+562bRKAJYfkp1mDft3Ntw==
X-Gm-Message-State: AOJu0Yyfsp839UkHAZ2lTPyjTbNOnyqGdHrzLtRYx3osMf8243BbTZWF
	ckxuZQdByFON2Tg79LAdwu5UcVgiOECv+rmaNvl10a1V16ONQJk6alX7pagOU2Y=
X-Google-Smtp-Source: AGHT+IEWR0naxsjqG6PjL5n5tEp1Ci8rJdxP3J1CbAApgRxLYFkmM+R0aL8qHW5Lv8+tjuuvrYAkhg==
X-Received: by 2002:a05:6a20:3ca0:b0:1b6:fadd:8862 with SMTP id adf61e73a8af0-1bcbb8ce3e2mr2590711637.6.1718806723107;
        Wed, 19 Jun 2024 07:18:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d2e8sm10689218b3a.107.2024.06.19.07.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:18:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Richard Weinberger <richard@nod.at>, 
 Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, 
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, 
 drbd-dev@lists.linbit.com, nbd@other.debian.org, 
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org, 
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20240617060532.127975-1-hch@lst.de>
References: <20240617060532.127975-1-hch@lst.de>
Subject: Re: move features flags into queue_limits v2
Message-Id: <171880672048.115609.5962725096227627176.b4-ty@kernel.dk>
Date: Wed, 19 Jun 2024 08:18:40 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 17 Jun 2024 08:04:27 +0200, Christoph Hellwig wrote:
> this is the third and last major series to convert settings to
> queue_limits for this merge window.  After a bunch of prep patches to
> get various drivers in shape, it moves all the queue_flags that specify
> driver controlled features into the queue limits so that they can be
> set atomically and are separated from the blk-mq internal flags.
> 
> Note that I've only Cc'ed the maintainers for drivers with non-mechanical
> changes as the Cc list is already huge.
> 
> [...]

Applied, thanks!

[01/26] xen-blkfront: don't disable cache flushes when they fail
        commit: dd9300e9eaeeb212f77ffeb72d1d8756107f1f1f
[02/26] sd: remove sd_is_zoned
        commit: be60e7700e6df1e16a2f60f45bece08e6140a46d
[03/26] sd: move zone limits setup out of sd_read_block_characteristics
        commit: 308ad58af49d6c4c3b7a36b98972cc9db4d7b36a
[04/26] loop: stop using loop_reconfigure_limits in __loop_clr_fd
        commit: c9055b44abe60da69aa4ee4fdcb78ee7fe733335
[05/26] loop: always update discard settings in loop_reconfigure_limits
        commit: ae0d40ff49642651f969883ef9fc79d69c1632d7
[06/26] loop: regularize upgrading the block size for direct I/O
        commit: a17ece76bcfe7b86327b19cae1652d7c62068a30
[07/26] loop: also use the default block size from an underlying block device
        commit: 4ce37fe0938b02b7b947029c40b72d76a22a3882
[08/26] loop: fold loop_update_rotational into loop_reconfigure_limits
        commit: 97dd4a43d69b74a114be466d6887e257971adfe9
[09/26] virtio_blk: remove virtblk_update_cache_mode
        commit: bbe5c84122b35c37f2706872fe34da66f0854b56
[10/26] nbd: move setting the cache control flags to __nbd_set_size
        commit: 6b377787a306253111404325aee98005b361e59a
[11/26] block: freeze the queue in queue_attr_store
        commit: af2814149883e2c1851866ea2afcd8eadc040f79
[12/26] block: remove blk_flush_policy
        commit: 70905f8706b62113ae32c8df721384ff6ffb6c6a
[13/26] block: move cache control settings out of queue->flags
        commit: 1122c0c1cc71f740fa4d5f14f239194e06a1d5e7
[14/26] block: move the nonrot flag to queue_limits
        commit: bd4a633b6f7c3c6b6ebc1a07317643270e751a94
[15/26] block: move the add_random flag to queue_limits
        commit: 39a9f1c334f9f27b3b3e6d0005c10ed667268346
[16/26] block: move the io_stat flag setting to queue_limits
        commit: cdb2497918cc2929691408bac87b58433b45b6d3
[17/26] block: move the stable_writes flag to queue_limits
        commit: 1a02f3a73f8c670eddeb44bf52a75ae7f67cfc11
[18/26] block: move the synchronous flag to queue_limits
        commit: aadd5c59c910427c0464c217d5ed588ff14e2502
[19/26] block: move the nowait flag to queue_limits
        commit: f76af42f8bf13d2620084f305f01691de9238fc7
[20/26] block: move the dax flag to queue_limits
        commit: f467fee48da4500786e145489787b37adae317c3
[21/26] block: move the poll flag to queue_limits
        commit: 8023e144f9d6e35f8786937e2f0c2fea0aba6dbc
[22/26] block: move the zoned flag into the features field
        commit: b1fc937a55f5735b98d9dceae5bb6ba262501f56
[23/26] block: move the zone_resetall flag to queue_limits
        commit: a52758a39768f441e468a41da6c15a59d6d6011a
[24/26] block: move the pci_p2pdma flag to queue_limits
        commit: 9c1e42e3c876c66796eda23e79836a4d92613a61
[25/26] block: move the skip_tagset_quiesce flag to queue_limits
        commit: 8c8f5c85b20d0a7dc0ab9b2a17318130d69ceb5a
[26/26] block: move the bounce flag into the features field
        commit: 339d3948c07b4aa2940aeb874294a7d6782cec16

Best regards,
-- 
Jens Axboe




