Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A90DB5F3
	for <lists+linux-s390@lfdr.de>; Thu, 17 Oct 2019 20:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503303AbfJQSWj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 17 Oct 2019 14:22:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34690 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503311AbfJQSWf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Oct 2019 14:22:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so1835797pgi.1
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 11:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=Vl0993kFOVCbFbBd0f73Vm2bgxp+dYjZuoT4X6x3qbo=;
        b=rPWkQnDfwO896k6YnFtZNdy1pIu+0tnFN+1p1K8OUhs3YoR73VnsG7IA1dKIli5fps
         pWW05HwFD+iaVk9qDOtgEwvSijgx7QBPrNpb/OY6gfdkkkfueued27c2575UQbAHEZgb
         UhDYdVSGOSc/goY89hcQNRw1M4PzZzJJoIkZ+nYIcReMey4tnlFhVDigDfYEUicDIa1F
         8kxv/3Px6ZkQOV8c5b+2K0q8bMIljQksBNLATGCp/I7O2RMnmYz72CaEceBF8oSQSRS5
         8mwDMzCaR3AmH/brr1DOCEYWTb3DdGbiyEk+3Exr1WVOwwtMBgDnr3F9l2IPBNqlnL8U
         Cc6A==
X-Gm-Message-State: APjAAAUVWnSWOZxf5civeNlTIMV+vOFCtVyLVugEuTPU8lpxDqQ1HPDp
        5xmjokdVgpSLX6ABCSCXTe1KGQ==
X-Google-Smtp-Source: APXvYqynD9rVIS1o3qWTvaQTxl9H6HgwDspwax1m/MNQ8kaTqQ6suPLQuCl8IkuSxv3eFErDBkUQ1g==
X-Received: by 2002:a17:90a:1b49:: with SMTP id q67mr6162405pjq.115.1571336554301;
        Thu, 17 Oct 2019 11:22:34 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s36sm3153399pgk.84.2019.10.17.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:22:33 -0700 (PDT)
Subject: [PATCH 3/3] pci: Default to PCI_MSI_IRQ_DOMAIN
Date:   Thu, 17 Oct 2019 11:19:37 -0700
Message-Id: <20191017181937.7004-4-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017181937.7004-1-palmer@sifive.com>
References: <20191017181937.7004-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        kstewart@linuxfoundation.org, pbonzini@redhat.com,
        firoz.khan@linaro.org, yamada.masahiro@socionext.com,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com,
        helgaas@kernel.org
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

As far as I can tell, the only reason there was an architecture
whitelist for PCI_MSI_IRQ_DOMAIN is because it requires msi.h.  I've
built this for all the architectures that play nice with make.cross, but
I haven't boot tested it anywhere.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a304f5ea11b9..77c1428cd945 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86 || RISCV
+	def_bool y
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.21.0

