Return-Path: <linux-s390+bounces-3278-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD28A1E1B
	for <lists+linux-s390@lfdr.de>; Thu, 11 Apr 2024 20:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA3F28A8FE
	for <lists+linux-s390@lfdr.de>; Thu, 11 Apr 2024 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F751369BD;
	Thu, 11 Apr 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aI/Km0ji"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8C38FA3;
	Thu, 11 Apr 2024 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857773; cv=none; b=t6upJ5YsiQXB8syRfgFeyqB9p8DNmsqmPlCJyM9Drmv4U+jj0Yx+/gJ+sax6rl5Ysvc/qm1lRYuUVn1ZbCt5gFleVpqLiIhFpshwi6f9OUIdbFfOIq1XZ/yRHp9OQP/uXdfVcjoVQF98FIGSxHtHahF3/6jNFB609qyVvZL6rD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857773; c=relaxed/simple;
	bh=JMTdAGD8MD/pbkdj+J+tnzBU2KPanJ0Go33kBW0D9C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeUMhxjCjYayrfBdKWfVmSM12YKMXwA1nS7e4hx0Mobq6/oyTS3Y8d/aEg+AJMR6RlfeSb0ekZis+TwvqmR7QlGCvHIFgb0BPmqFsD3aeMnloXbmDAftuTHzYLP+VTNl2Vo4bCVHdTIOsH14RzMKCcC5VJ2y2iKM88wKlWsDDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aI/Km0ji; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Apr 2024 13:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712857769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/TZdE1FK3O4qkESTbUB1nUL6z8CdzrLZmjris90VHw=;
	b=aI/Km0jiSMVL4A1tCs8hlsrV66vbuWxJKZ+EgkonCW2LmuJAGBaIivtgu4+3HhSKhbSBh3
	uS3+3l/YqK0GsHToDiJSOy8jQgouByPKNokiyLYxRwngjkex1lryU/nDL4TDH7+GmcHLtc
	35AcbG0Y+MpEd8VLadpzkGxeP5lZ1Bo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de, 
	kent.overstreet@gmail.com, joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org, 
	chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com, 
	konishi.ryusuke@gmail.com, willy@infradead.org, akpm@linux-foundation.org, hare@suse.de, 
	p.raghav@samsung.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v3 for-6.8/block 07/17] bcachefs: remove dead
 function bdev_sectors()
Message-ID: <2pat6ombemqnq5wjl6eb4lbip2pfgg5tkubmbwqphvcvpdc6cu@poiexziaa2q4>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-8-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085712.1766333-8-yukuai1@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 21, 2023 at 04:57:02PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> bdev_sectors() is not used hence remove it.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

> ---
>  fs/bcachefs/util.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
> index 2984b57b2958..22a0acc1704f 100644
> --- a/fs/bcachefs/util.h
> +++ b/fs/bcachefs/util.h
> @@ -516,11 +516,6 @@ static inline unsigned fract_exp_two(unsigned x, unsigned fract_bits)
>  void bch2_bio_map(struct bio *bio, void *base, size_t);
>  int bch2_bio_alloc_pages(struct bio *, size_t, gfp_t);
>  
> -static inline sector_t bdev_sectors(struct block_device *bdev)
> -{
> -	return bdev->bd_inode->i_size >> 9;
> -}
> -
>  #define closure_bio_submit(bio, cl)					\
>  do {									\
>  	closure_get(cl);						\
> -- 
> 2.39.2
> 

