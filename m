Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC07390E37
	for <lists+linux-s390@lfdr.de>; Wed, 26 May 2021 04:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhEZCSI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 25 May 2021 22:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhEZCSH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 22:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621995396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bL9t6jBzKp1v0IgXonQD9Y9rV4qPdE8wVFwvTWv9yY=;
        b=E1Q83Wyd3AzEfccJHabVNpi/FXrAPobNrHMtMtVtR5FqubxlNJPBltfNJH6MvubKFSEJV1
        hVosVnXaoRRZwpHtnVHrMa1ZgFyybDpstVphrXp8ZtYZg4KRj47GrG1MWGNheNS+4kti07
        cyRfUu3aZnDGMt+xiubljpdvPzvyx+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-QQpK_NpfNxCeH5ot18BAwQ-1; Tue, 25 May 2021 22:16:34 -0400
X-MC-Unique: QQpK_NpfNxCeH5ot18BAwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D17180FD65;
        Wed, 26 May 2021 02:16:32 +0000 (UTC)
Received: from T590 (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 974BA100760F;
        Wed, 26 May 2021 02:16:15 +0000 (UTC)
Date:   Wed, 26 May 2021 10:16:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 7/8] block: factor out a part_devt helper
Message-ID: <YK2vasLTqe9qHapw@T590>
References: <20210525061301.2242282-1-hch@lst.de>
 <20210525061301.2242282-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525061301.2242282-8-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 25, 2021 at 08:13:00AM +0200, Christoph Hellwig wrote:
> Add a helper to find the dev_t for a disk + partno tuple.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

