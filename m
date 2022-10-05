Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5345F4F5D
	for <lists+linux-s390@lfdr.de>; Wed,  5 Oct 2022 07:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJEFLf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 5 Oct 2022 01:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJEFLa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Oct 2022 01:11:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C61C69
        for <linux-s390@vger.kernel.org>; Tue,  4 Oct 2022 22:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664946688; x=1696482688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t4Ggk8JN7aJqaDrHkVXVhSu8+EOy8cvFecQ8rYNiwuM=;
  b=oOVx3DxfTksLmySJrx00s3AXDoIMjPnTzhgTvWanwH+i6WqGbOy5Tgt3
   Lrfnyt15ZRLoa51Tehf1gxFsr7V8iq67YqcImRAm4nYM5GYxXFZa8wVaS
   4RTWWiY9Xl5Dzy7dHjXnekgj0HVQ2+ai8RUovcBf3WxdRnQUDRDqhtgha
   k/F/x19+9OPGNW5CopFp0rehEfLZJgQywp+D+fw/SacqL93ZSlvgyWH9q
   j6FHwwn4meL+acCA0JG7qppnABQhPi8K3R5/q6HytCOE5CGUgKDTvuso4
   D7BA3wTqR1x2hlnQnrq25a0/BlVa+hJxPedojDy42ojznf5HNgALwoyWn
   A==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="211366258"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:11:26 +0800
IronPort-SDR: CPDKvNSyqDQUq9O7+qI840grjztsBxu7tsMRHASOlpc+CJ5ehEsNlK9BaIexzJCaB8HL6dZCwN
 QLebdFZDtlQqWZYAGtmHSzx2ONndcnmtYuafnVSWI8i+rqoXeoWA19BTmX6WLGfSFiRm46t7zu
 2qiJmeAYc+P8E7NAybuw+FN7VuHgBZSeNcROW2RRyCYri08ACwBFgIfSo8cF2nB2xyzgHtAtMH
 0lWs9OcsEebg0vKT9YdzDj3zi6KDiUxpyCcRBi0MNe0MBexFYMp4v/24t0FyZeVlfE4YZuERc0
 eWSVNvEu8WpG6YDuHeYGRyTF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:25:40 -0700
IronPort-SDR: RrTVS1oLgpmS8uqlky+SPlOx/rS+gyyO38KStYOXv19jhSe1tgAg++rFRS6Fdjke+N0YplSCrB
 NnNC3MGd93Hzj6D+i5jAmfvmHJbvAQg2VYPND379VNgtg88f2/IASP7e2nKEhssy/+bnQ5i6v7
 xh+ODcNKcRQg0lp9qEVyQAIcyk2/jOxqOTXEfzzewv12rid21sT9O/xKW7J8GWopCRiZTLCwoI
 NJQeLlaEXBpimnb/+PbFIR7LmovQTIavvuBpDPX3rO22LjehnEf7hPtPuXfq3/B9mBrEfKVUc7
 zzQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:11:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2jT5CFHz1RWxq
        for <linux-s390@vger.kernel.org>; Tue,  4 Oct 2022 22:11:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664946685; x=1667538686; bh=t4Ggk8JN7aJqaDrHkVXVhSu8+EOy8cvFecQ
        8rYNiwuM=; b=tLHviaNBSZE88xLdQVOFiXAWb32/6ojwACuLRRnG8xU9QNHEWqD
        f50ptDx5qVWJYd6IRLeybuJOMi2M6t5KRZI3AxvWZksBtihDPujw8HBCFBVcUIpO
        ZfC3UqxRdafUnH0qS8IsrY5TqmTzapsn4pisieIRMNWD7VofvqnWQyDmT8TxJChB
        KhPs6ot/7bsSNTEjACMw8pxc5R4wP5XrPylMOZlJtJDzi6yEHX9iayUOd3W/Y9EM
        lajOzQCUf/ULm/9m5UmUAMRiYIxjEIGpDaIN3IIJblmsuApIMI/WI7OzPk1XLIjn
        5iKMLXkiVy+cs7ipqm1Z7lpyxgZvmyF7ogw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7SYUoJAIlyHI for <linux-s390@vger.kernel.org>;
        Tue,  4 Oct 2022 22:11:25 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2jD37C6z1RvLy;
        Tue,  4 Oct 2022 22:11:12 -0700 (PDT)
Message-ID: <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 14:11:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, efremov@linux.com, josef@toxicpanda.com,
        idryomov@gmail.com, dongsheng.yang@easystack.cn,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        ohad@wizery.com, andersson@kernel.org,
        baolin.wang@linux.alibaba.com, ulf.hansson@linaro.org,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, sth@linux.ibm.com,
        hoeppner@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bhelgaas@google.com,
        john.garry@huawei.com, mcgrof@kernel.org,
        christophe.jaillet@wanadoo.fr, vaibhavgupta40@gmail.com,
        wsa+renesas@sang-engineering.com, johannes.thumshirn@wdc.com,
        bvanassche@acm.org, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com,
        christoph.boehmwalder@linbit.com, joel@jms.id.au,
        vincent.whitchurch@axis.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, asahi@lists.linux.dev
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005032257.80681-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/5/22 12:22, Chaitanya Kulkarni wrote:
> Add and use the helper to initialize the common fields of the tag_set
> such as blk_mq_ops, number of h/w queues, queue depth, command size,
> numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
> is spread all over the block drivers. This avoids the code repetation of
> the inialization code of the tag set in current block drivers and any

s/inialization/initialization
s/repetation/repetition

> future ones.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  block/blk-mq.c                | 20 ++++++++++++++++++++
>  drivers/block/null_blk/main.c | 10 +++-------
>  include/linux/blk-mq.h        |  5 +++++
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..e3a8dd81bbe2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4341,6 +4341,26 @@ static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
>  	return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
>  }
>  
> +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
> +		unsigned int queue_depth, unsigned int cmd_size, int numa_node,
> +		unsigned int timeout, unsigned int flags, void *driver_data)

That is an awful lot of arguments... I would be tempted to say pack all
these into a struct but then that would kind of negate this patchset goal.
Using a function with that many arguments will be error prone, and hard to
review... Not a fan.

> +{
> +	if (!set)
> +		return;
> +
> +	set->ops = ops;
> +	set->nr_hw_queues = nr_hw_queues;
> +	set->queue_depth = queue_depth;
> +	set->cmd_size = cmd_size;
> +	set->numa_node = numa_node;
> +	set->timeout = timeout;
> +	set->flags = flags;
> +	set->driver_data = driver_data;
> +}
> +

No blank line here.

> +EXPORT_SYMBOL_GPL(blk_mq_init_tag_set);
> +
>  /*
>   * Alloc a tag set to be associated with one or more request queues.
>   * May fail with EINVAL for various error conditions. May adjust the
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 1f154f92f4c2..0b07aab980c4 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1926,13 +1926,9 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
>  			flags |= BLK_MQ_F_BLOCKING;
>  	}
>  
> -	set->ops = &null_mq_ops;
> -	set->cmd_size	= sizeof(struct nullb_cmd);
> -	set->flags = flags;
> -	set->driver_data = nullb;
> -	set->nr_hw_queues = hw_queues;
> -	set->queue_depth = queue_depth;
> -	set->numa_node = numa_node;
> +	blk_mq_init_tag_set(set, &null_mq_ops, hw_queues, queue_depth,
> +			sizeof(struct nullb_cmd), numa_node, 0, flags, nullb);
> +
>  	if (poll_queues) {
>  		set->nr_hw_queues += poll_queues;
>  		set->nr_maps = 3;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index ba18e9bdb799..06087a8e4398 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -708,6 +708,11 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  		struct request_queue *q);
>  void blk_mq_destroy_queue(struct request_queue *);
>  
> +

No need for the extra whiteline.

> +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
> +		unsigned int queue_depth, unsigned int cmd_size, int numa_node,
> +		unsigned int timeout, unsigned int flags, void *driver_data);
>  int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
>  int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
>  		const struct blk_mq_ops *ops, unsigned int queue_depth,

-- 
Damien Le Moal
Western Digital Research

